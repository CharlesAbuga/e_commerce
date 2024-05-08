import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/bloc/update_user_info/update_user_info_bloc.dart';
import 'package:ecommerce_app/screens/authentication/welcome_screen.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/carousel.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // ignore: empty_constructor_bodies
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        print(state.status);
        if (state.status == AuthenticationStatus.authenticated) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    MyUserBloc(myUserRepository: FirebaseUserRepository())
                      ..add(GetMyUser(
                          myUserId: context
                              .read<AuthenticationBloc>()
                              .state
                              .user!
                              .uid)),
              ),
              BlocProvider(
                create: (context) => UpdateUserInfoBloc(
                    userRepository:
                        context.read<AuthenticationBloc>().userRepository),
              ),
            ],
            child: BlocProvider(
              create: (context) =>
                  MyUserBloc(myUserRepository: FirebaseUserRepository())
                    ..add(GetMyUser(
                        myUserId: context
                            .read<AuthenticationBloc>()
                            .state
                            .user!
                            .uid)),
              child: BlocBuilder<MyUserBloc, MyUserState>(
                builder: (context, state) {
                  return Scaffold(
                    backgroundColor: Colors.grey[100],
                    appBar: MediaQuery.of(context).size.width < 800
                        ? PreferredSize(
                            preferredSize:
                                Size(MediaQuery.of(context).size.width, 70),
                            child: const AppBarSmall())
                        : PreferredSize(
                            preferredSize:
                                Size(MediaQuery.of(context).size.width, 70),
                            child: const Center(child: AppBarMain())),
                    drawer: MediaQuery.of(context).size.width < 800
                        ? const DrawerWidget()
                        : null,
                    body: BlocBuilder<GetProductBloc, GetProductState>(
                      builder: (context, state) {
                        if (state is GetProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetProductFailure) {
                          return const Center(
                            child: Text('Failed to fetch products'),
                          );
                        } else if (state is GetProductSuccess) {
                          final sortedProducts = state.products
                            ..sort(
                                (a, b) => b.createdAt.compareTo(a.createdAt));
                          return ListView(
                            children: [
                              MediaQuery.of(context).size.width < 800
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 10,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 30,
                                        child: Center(
                                          child: Marquee(
                                            text:
                                                '-- Shipping within Mombasa is 300/- and outside Mombasa is 500/- ',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            scrollAxis: Axis.horizontal,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            velocity: 70.0,
                                            startPadding: 10.0,
                                            blankSpace: 90,
                                            accelerationDuration:
                                                Duration(seconds: 1),
                                            accelerationCurve: Curves.linear,
                                            decelerationDuration:
                                                Duration(milliseconds: 500),
                                            decelerationCurve: Curves.easeOut,
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(height: 20),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [CarouselSliderHome()],
                              ),
                              Padding(
                                padding: MediaQuery.of(context).size.width > 800
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 37.0, vertical: 8)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8),
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: ListTile(
                                      title: Text('For Men',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('View All',
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: state.products
                                        .where((product) =>
                                            product.gender == 'Male' &&
                                            product.ageGroup == 'Adults')
                                        .length,
                                    itemBuilder: (context, index) {
                                      final menProduct = state.products
                                          .where((product) =>
                                              product.gender == 'Male' &&
                                              product.ageGroup == 'Adults')
                                          .toList()[index];
                                      return SizedBox(
                                        width: 250,
                                        child: ProductCard(product: menProduct),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: MediaQuery.of(context).size.width > 800
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 37.0, vertical: 8)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8),
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: ListTile(
                                      title: Text('For Women',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('View All',
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: state.products
                                        .where((product) =>
                                            product.gender == 'Female' &&
                                            product.ageGroup == 'Adults')
                                        .length,
                                    itemBuilder: (context, index) {
                                      final womenProduct = state.products
                                          .where((product) =>
                                              product.gender == 'Female' &&
                                              product.ageGroup == 'Adults')
                                          .toList()[index];
                                      return SizedBox(
                                        width: 250,
                                        child:
                                            ProductCard(product: womenProduct),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: MediaQuery.of(context).size.width > 800
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 37.0, vertical: 8)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 8),
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: ListTile(
                                      title: Text('For Children',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('View All',
                                              style: TextStyle(
                                                fontSize: 14,
                                              )),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: state.products
                                        .where((product) =>
                                            product.ageGroup == 'Children')
                                        .length,
                                    itemBuilder: (context, index) {
                                      final womenProduct = state.products
                                          .where((product) =>
                                              product.ageGroup == 'Children')
                                          .toList()[index];
                                      return SizedBox(
                                        width: 250,
                                        child:
                                            ProductCard(product: womenProduct),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 200,
                                width: 600,
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'RECENTLY ADDED PRODUCTS',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width > 900
                                            ? 20
                                            : 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30, top: 20),
                                child: SizedBox(
                                  height: 280,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: state.products.length,
                                      itemBuilder: (context, index) {
                                        return SizedBox(
                                          width: 250,
                                          child: ProductCard(
                                              product: sortedProducts[index]),
                                        );
                                      }),
                                ),
                              )
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}

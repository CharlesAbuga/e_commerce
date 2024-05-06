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
                            shrinkWrap: true,
                            children: [
                              MediaQuery.of(context).size.width < 800
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: 10,
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 50),
                                          child: const Padding(
                                            padding: EdgeInsets.only(
                                                left: 115, top: 20),
                                            child: Text(
                                              'WELCOME BACK',
                                              style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [CarouselSliderHome()],
                              ),
                              const Center(
                                child: Text('FOR MEN',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: SizedBox(
                                  height: 300,
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
                              const Center(
                                child: Text('FOR WOMEN',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: SizedBox(
                                  height: 300,
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
                              const Center(
                                child: Text('CHILDREN',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: SizedBox(
                                  height: 300,
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
                              Text(
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
                              const SizedBox(height: 5),
                              const Icon(CupertinoIcons.chevron_down),
                              MediaQuery.of(context).size.width > 1000
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                          left: 70.0, right: 70, top: 20),
                                      child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 5,
                                                  mainAxisExtent: 320,
                                                  crossAxisCount: 5),
                                          itemCount: state.products.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return ProductCard(
                                                product: sortedProducts[index]);
                                          }),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView.builder(
                                          scrollDirection: Axis.vertical,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisSpacing: 5,
                                                  mainAxisExtent: 280,
                                                  crossAxisCount: 2),
                                          itemCount: state.products.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return ProductCard(
                                                product: sortedProducts[index]);
                                          }),
                                    ),
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

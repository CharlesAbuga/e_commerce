import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:ecommerce_app/bloc/update_user_info/update_user_info_bloc.dart';
import 'package:ecommerce_app/screens/authentication/welcome_screen.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/carousel.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/product_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:marquee/marquee.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // ignore: empty_constructor_bodies
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // int _selectedIndex = 0;
  List<Product> _products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  Future<void> _fetchProducts() async {
    // Your logic to fetch products from the GetProductBloc or another source
    // Replace with actual implementation
    final bloc = context.read<GetProductBloc>()..add(GetProduct());
    // Assuming GetProducts event exists

    // Update state with fetched products
    setState(() {
      // Handle potential null state
    });
  }

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
                          return RefreshIndicator(
                            onRefresh: () async {
                              setState(() {
                                _fetchProducts();
                              });
                            },
                            child: ListView(
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
                                  padding:
                                      MediaQuery.of(context).size.width > 800
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
                                    child: Center(
                                      child: ListTile(
                                        title: const Text('For Men',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context)
                                                .pushNamed(RouteConstants.mens);
                                          },
                                          child: const Row(
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
                                          .take(15)
                                          .length,
                                      itemBuilder: (context, index) {
                                        final menProduct = state.products
                                            .where((product) =>
                                                product.gender == 'Male' &&
                                                product.ageGroup == 'Adults')
                                            .toList()[index];
                                        return SizedBox(
                                          width: 250,
                                          child:
                                              ProductCard(product: menProduct),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding:
                                      MediaQuery.of(context).size.width > 800
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
                                    child: Center(
                                      child: ListTile(
                                        title: const Text('For Women',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(
                                                RouteConstants.womens);
                                          },
                                          child: const Row(
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
                                          .take(15)
                                          .length,
                                      itemBuilder: (context, index) {
                                        final womenProduct = state.products
                                            .where((product) =>
                                                product.gender == 'Female' &&
                                                product.ageGroup == 'Adults')
                                            .toList()[index];
                                        return SizedBox(
                                          width: 250,
                                          child: ProductCard(
                                              product: womenProduct),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding:
                                      MediaQuery.of(context).size.width > 800
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
                                    child: Center(
                                      child: ListTile(
                                        title: const Text('For Children',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        trailing: GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).pushNamed(
                                                RouteConstants.children);
                                          },
                                          child: const Row(
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
                                          .take(15)
                                          .length,
                                      itemBuilder: (context, index) {
                                        final womenProduct = state.products
                                            .where((product) =>
                                                product.ageGroup == 'Children')
                                            .toList()[index];
                                        return SizedBox(
                                          width: 250,
                                          child: ProductCard(
                                              product: womenProduct),
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
                                          MediaQuery.of(context).size.width >
                                                  900
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
                                      left: 30.0, right: 30),
                                  child: SizedBox(
                                    height: 280,
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            state.products.take(15).length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: 250,
                                            child: ProductCard(
                                                product: sortedProducts[index]),
                                          );
                                        }),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Footer(),
                              ],
                            ),
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

class Footer extends StatefulWidget {
  const Footer({
    super.key,
  });

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  Color logoutButtonColor = Colors.black;
  Color logOutTextColor = Colors.white;
  Color orderButtonColor = Colors.black;
  Color orderTextColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 600,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Follow us on: '),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.facebook)),
                  IconButton(
                      onPressed: () {},
                      icon: const FaIcon(FontAwesomeIcons.instagram)),
                  const SizedBox(width: 25),
                  MediaQuery.of(context).size.width > 1100
                      ? Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    logoutButtonColor, // background color // text color
                              ),
                              onPressed: () {
                                context
                                    .read<SignInBloc>()
                                    .add(const SignOutRequired());
                              },
                              onHover: (value) {
                                setState(() {
                                  if (value) {
                                    logoutButtonColor = Colors.red;
                                    logOutTextColor = Colors.black;
                                  } else {
                                    logoutButtonColor = Colors.black;
                                    logOutTextColor = Colors.white;
                                  }
                                });
                              },
                              child: Text('Logout',
                                  style: TextStyle(
                                      color: logOutTextColor, fontSize: 10)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor:
                                    orderButtonColor, // background color // text color
                              ),
                              onPressed: () {
                                GoRouter.of(context)
                                    .goNamed(RouteConstants.orders);
                              },
                              onHover: (value) {
                                setState(() {
                                  if (value) {
                                    orderButtonColor = Colors.white;
                                    orderTextColor = Colors.black;
                                  } else {
                                    orderButtonColor = Colors.black;
                                    orderTextColor = Colors.white;
                                  }
                                });
                              },
                              child: Text('Orders',
                                  style: TextStyle(
                                      color: orderTextColor, fontSize: 10)),
                            ),
                          ],
                        )
                      : const SizedBox(
                          width: 5,
                        ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 25),
            MediaQuery.of(context).size.width > 1100
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('CHILDREN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.babyClothes);
                                },
                                child: const Text('Clothes')),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.babyShoes);
                                },
                                child: const Text('Shoes')),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.babyAccessories);
                                },
                                child: const Text('Accessories')),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('MEN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.mensClothes);
                                },
                                child: const Text('Clothes')),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.mensShoes);
                                },
                                child: const Text('Shoes')),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.mensAccessories);
                                },
                                child: const Text('Accessories')),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('WOMEN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 7,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.womensClothes);
                                },
                                child: const Text('Clothes')),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context)
                                      .goNamed(RouteConstants.womensShoes);
                                },
                                child: const Text('Shoes')),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                                onTap: () {
                                  GoRouter.of(context).goNamed(
                                      RouteConstants.womensAccessories);
                                },
                                child: const Text('Accessories')),
                          )
                        ],
                      )
                    ],
                  )
                : const SizedBox(
                    height: 1,
                  ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            MediaQuery.of(context).size.width > 1100
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text('Contact Us:  ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('0712345678'),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Email Us:  ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('godfreycharles@gmail.com')
                      ])
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Contact Us:  ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('0712345678'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Email Us:  ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('godfreycharles@gmail.com')
                          ],
                        ),
                      ]),
            const SizedBox(
              height: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              '© 2024. All Rights Reserved.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )
          ],
        ));
  }
}

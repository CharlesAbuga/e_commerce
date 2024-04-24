import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
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
        if (state.status == AuthenticationStatus.authenticated) {
          return Scaffold(
            appBar: MediaQuery.of(context).size.width < 800
                ? PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 100),
                    child: const AppBarSmall())
                : PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 70),
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
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      MediaQuery.of(context).size.width < 800
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      IconButton.filled(
                                        onPressed: () {},
                                        tooltip: 'For men',
                                        icon: const Icon(Icons.man),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Men\'s clothes',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton.filled(
                                        onPressed: () {},
                                        icon: const Icon(Icons.woman),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Women\'s Clothes',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton.filled(
                                        onPressed: () {},
                                        icon: const Icon(Icons.child_care),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        'Children\'s clothes',
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 50),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.only(left: 115, top: 20),
                                    child: Text(
                                      'Welcome',
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
                      Text(
                        'Products',
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.width > 900 ? 30 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 5),
                      const Icon(CupertinoIcons.chevron_down),
                      MediaQuery.of(context).size.width > 900
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          mainAxisExtent: 320,
                                          crossAxisCount: 5),
                                  itemCount: state.products.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ProductCard(
                                        product: state.products[index]);
                                  }),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 320,
                                          crossAxisCount: 2),
                                  itemCount: state.products.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ProductCard(
                                        product: state.products[index]);
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
        } else {
          return const WelcomeScreen();
        }
      },
    );
  }
}

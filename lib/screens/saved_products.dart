import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/bloc/update_user_info/update_user_info_bloc.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:ecommerce_app/widgets/hover_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

class SavedProducts extends StatefulWidget {
  const SavedProducts({super.key});

  @override
  State<SavedProducts> createState() => _SavedProductsState();
}

class _SavedProductsState extends State<SavedProducts> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MediaQuery.of(context).size.width < 1000
            ? PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 70),
                child: const AppBarSmall())
            : PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 70),
                child: const Center(child: AppBarMain())),
        drawer: MediaQuery.of(context).size.width < 800
            ? const DrawerWidget()
            : null,
        body: SingleChildScrollView(
            child: BlocProvider(
          create: (context) =>
              AuthenticationBloc(myUserRepository: FirebaseUserRepository()),
          child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state.status == AuthenticationStatus.authenticated) {
                return BlocProvider(
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
                      if (state.status == MyUserStatus.loading) {
                        return const CircularProgressIndicator();
                      } else if (state.status == MyUserStatus.success) {
                        return MediaQuery.of(context).size.width > 800
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 290),
                                  itemCount: state.user!.savedProducts!.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        state.user!.savedProducts![index];
                                    return Theme(
                                      data: ThemeData(
                                        primaryColor: Colors.white,
                                        highlightColor: Colors.white,
                                      ),
                                      child: Card(
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context).goNamed(
                                                    RouteConstants.details,
                                                    pathParameters: {
                                                      'productId':
                                                          product['productId']
                                                    },
                                                    extra: product);
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10)),
                                                child: Image.network(
                                                    product['imageUrl'][0],
                                                    fit: BoxFit.fitWidth,
                                                    height: 180,
                                                    width: double.infinity),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, left: 12),
                                              child: Text(
                                                product['name'],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                HoverButton(
                                                    buttonText: 'REMOVE',
                                                    onPressed: () {
                                                      String productId = product[
                                                          'productId']; // Assuming each product has an 'id' field
                                                      context
                                                          .read<
                                                              UpdateUserInfoBloc>()
                                                          .add(
                                                            DeleteSavedProducts(
                                                              context
                                                                  .read<
                                                                      MyUserBloc>()
                                                                  .state
                                                                  .user!
                                                                  .copyWith(
                                                                    cartProducts: context
                                                                        .read<
                                                                            MyUserBloc>()
                                                                        .state
                                                                        .user!
                                                                        .savedProducts!
                                                                      ..removeAt(
                                                                          index),
                                                                  ),
                                                              productId,
                                                            ),
                                                          );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          backgroundColor:
                                                              Colors.red,
                                                          content: const Text(
                                                              'Product removed'),
                                                        ),
                                                      );
                                                      setState(() {});
                                                    }),
                                                HoverButton(
                                                    buttonText: 'ADD TO CART',
                                                    onPressed: () {}),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 5,
                                          mainAxisExtent: 220),
                                  itemCount: state.user!.savedProducts!.length,
                                  itemBuilder: (context, index) {
                                    final product =
                                        state.user!.savedProducts![index];
                                    return Theme(
                                      data: ThemeData(
                                        primaryColor: Colors.white,
                                        highlightColor: Colors.white,
                                      ),
                                      child: Card(
                                        surfaceTintColor: Colors.transparent,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                GoRouter.of(context).goNamed(
                                                    RouteConstants.details,
                                                    pathParameters: {
                                                      'productId':
                                                          product['productId']
                                                    },
                                                    extra: product);
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        topRight:
                                                            Radius.circular(
                                                                10)),
                                                child: Image.network(
                                                    product['imageUrl'][0],
                                                    fit: BoxFit.cover,
                                                    height: 120,
                                                    width: double.infinity),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, left: 5),
                                              child: Text(
                                                product['name'],
                                                style: const TextStyle(
                                                    fontSize: 14),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton.filled(
                                                  iconSize: 20,
                                                  hoverColor: Colors.red,
                                                  style: ButtonStyle(
                                                    fixedSize:
                                                        MaterialStateProperty
                                                            .all(const Size(
                                                                25, 25)),
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.black),
                                                  ),
                                                  color: Colors.white,
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () {
                                                    String productId = product[
                                                        'productId']; // Assuming each product has an 'id' field
                                                    context
                                                        .read<
                                                            UpdateUserInfoBloc>()
                                                        .add(
                                                          DeleteSavedProducts(
                                                            context
                                                                .read<
                                                                    MyUserBloc>()
                                                                .state
                                                                .user!
                                                                .copyWith(
                                                                  savedProducts: context
                                                                      .read<
                                                                          MyUserBloc>()
                                                                      .state
                                                                      .user!
                                                                      .savedProducts!
                                                                    ..removeAt(
                                                                        index),
                                                                ),
                                                            productId,
                                                          ),
                                                        );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: const Text(
                                                            'Product removed'),
                                                      ),
                                                    );
                                                    setState(() {});
                                                  },
                                                ),
                                                HoverButton(
                                                    buttonText: 'ADD TO CART',
                                                    onPressed: () {}),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                      }
                      return const Text('Error');
                    },
                  ),
                );
              }
              return const Text('Error');
            },
          ),
        )));
  }
}

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/bloc/update_user_info/update_user_info_bloc.dart';
import 'package:ecommerce_app/screens/authentication/welcome_screen.dart';
import 'package:ecommerce_app/widgets/appbar.dart';
import 'package:ecommerce_app/widgets/appbar_small.dart';
import 'package:ecommerce_app/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:user_repository/user_repository.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => FirebaseUserRepository(),
      child: Scaffold(
        appBar: MediaQuery.of(context).size.width < 800
            ? PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 70),
                child: const AppBarSmall())
            : PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 70),
                child: const Center(child: AppBarMain())),
        drawer: MediaQuery.of(context).size.width < 800
            ? const DrawerWidget()
            : null,
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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
                child: BlocConsumer<MyUserBloc, MyUserState>(
                  listener: (context, state) => {},
                  builder: (context, state) {
                    if (state.status == MyUserStatus.loading) {
                      try {
                        print(state.user!.id);
                      } catch (e) {
                        print(e.toString());
                      }

                      return const Center(child: CircularProgressIndicator());
                    } else if (state.status == MyUserStatus.success) {
                      if (MediaQuery.of(context).size.width > 1350) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 200.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 100.0, right: 50),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        StreamBuilder<DocumentSnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(context
                                                    .read<AuthenticationBloc>()
                                                    .state
                                                    .user!
                                                    .uid)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return const Text(
                                                    'Something went wrong');
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }

                                              final cartProducts =
                                                  (snapshot.data!.data() as Map<
                                                              String, dynamic>)[
                                                          'cartProducts']
                                                      as List<dynamic>?;

                                              return ListView.builder(
                                                shrinkWrap: true,
                                                primary: false,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: cartProducts!.length,
                                                itemBuilder: (context, index) {
                                                  final cartproduct =
                                                      cartProducts[index];
                                                  return Container(
                                                    height: 130,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    child: Card(
                                                      surfaceTintColor:
                                                          Colors.transparent,
                                                      color: Colors.grey[200],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  Image.network(
                                                                cartproduct[
                                                                    'imageUrl'][0],
                                                                fit: BoxFit
                                                                    .cover,
                                                                width: 170,
                                                                height: 100,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 350,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                    child: Text(
                                                                        cartproduct[
                                                                            'name']),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .only(
                                                                            left:
                                                                                8.0),
                                                                        child:
                                                                            Text(
                                                                          'Ksh ${(cartproduct['price'] * cartproduct['quantity']).toString()}',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  BlocBuilder<
                                                                      UpdateUserInfoBloc,
                                                                      UpdateUserInfoState>(
                                                                    builder:
                                                                        (context,
                                                                            state) {
                                                                      return Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                IconButton.outlined(
                                                                              icon: const Icon(CupertinoIcons.minus),
                                                                              onPressed: () async {
                                                                                if (cartproduct['quantity'] > 1) {
                                                                                  // Decrease quantity
                                                                                  cartproduct['quantity'] -= 1;

                                                                                  final userDoc = FirebaseFirestore.instance.collection('users').doc(context.read<AuthenticationBloc>().state.user!.uid);
                                                                                  final userSnapshot = await userDoc.get();
                                                                                  final userCartProducts = (userSnapshot.data() as Map<String, dynamic>)['cartProducts'] as List<dynamic>;

                                                                                  final existingProductIndex = userCartProducts.indexWhere((product) => product['productId'] == cartproduct['productId']);
                                                                                  if (existingProductIndex != -1) {
                                                                                    // Update the quantity of the existing product
                                                                                    userCartProducts[existingProductIndex]['quantity'] = cartproduct['quantity'];
                                                                                  }

                                                                                  await userDoc.update({
                                                                                    'cartProducts': userCartProducts,
                                                                                  });
                                                                                }
                                                                                // Increase quantity
                                                                              },
                                                                            ),
                                                                          ),
                                                                          StreamBuilder<DocumentSnapshot>(
                                                                              stream: FirebaseFirestore.instance.collection('users').doc(context.read<AuthenticationBloc>().state.user!.uid).snapshots(),
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.hasError) {
                                                                                  log(snapshot.error.toString());
                                                                                } else if (snapshot.hasData) {
                                                                                  final cartProducts = (snapshot.data!.data() as Map<String, dynamic>)['cartProducts'] as List<dynamic>?;
                                                                                  return Text(cartProducts![index]['quantity'].toString());
                                                                                } else {
                                                                                  return const SizedBox();
                                                                                }
                                                                                return const SizedBox();
                                                                              }),
                                                                          Transform
                                                                              .scale(
                                                                            scale:
                                                                                0.7,
                                                                            child:
                                                                                IconButton.outlined(
                                                                              icon: const Icon(CupertinoIcons.add),
                                                                              onPressed: () async {
                                                                                // Get the product to be added
                                                                                final cartproduct = cartProducts[index];
                                                                                cartproduct['quantity'] = (cartproduct['quantity'] ?? 0) + 1;

                                                                                final userDoc = FirebaseFirestore.instance.collection('users').doc(context.read<AuthenticationBloc>().state.user!.uid);
                                                                                final userSnapshot = await userDoc.get();
                                                                                final userCartProducts = (userSnapshot.data() as Map<String, dynamic>)['cartProducts'] as List<dynamic>;

                                                                                final existingProductIndex = userCartProducts.indexWhere((product) => product['productId'] == cartproduct['productId']);
                                                                                if (existingProductIndex != -1) {
                                                                                  // If the product exists, update its quantity
                                                                                  userCartProducts[existingProductIndex]['quantity'] = cartproduct['quantity'];
                                                                                } else {
                                                                                  // If the product doesn't exist, add it to the cart
                                                                                  userCartProducts.add(cartproduct);
                                                                                }

                                                                                await userDoc.update({
                                                                                  'cartProducts': userCartProducts,
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          BlocBuilder<
                                                              UpdateUserInfoBloc,
                                                              UpdateUserInfoState>(
                                                            builder: (context,
                                                                state) {
                                                              return StreamBuilder<
                                                                      DocumentSnapshot>(
                                                                  stream: FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(context
                                                                          .read<
                                                                              AuthenticationBloc>()
                                                                          .state
                                                                          .user!
                                                                          .uid)
                                                                      .snapshots(),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasError) {
                                                                      return const Text(
                                                                          'Something went wrong');
                                                                    } else if (snapshot
                                                                            .connectionState ==
                                                                        ConnectionState
                                                                            .waiting) {
                                                                      return const Center(
                                                                        child:
                                                                            CircularProgressIndicator(),
                                                                      );
                                                                    }
                                                                    final cartProducts = (snapshot
                                                                            .data!
                                                                            .data()
                                                                        as Map<
                                                                            String,
                                                                            dynamic>)['cartProducts'] as List<
                                                                        dynamic>?;
                                                                    final cartProduct =
                                                                        cartProducts![
                                                                            index];
                                                                    return StreamBuilder<
                                                                            MyUser>(
                                                                        stream: context.read<FirebaseUserRepository>().userStream(context
                                                                            .read<
                                                                                AuthenticationBloc>()
                                                                            .state
                                                                            .user!
                                                                            .uid),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasError) {
                                                                            return const Text('Something went wrong');
                                                                          } else if (snapshot.connectionState ==
                                                                              ConnectionState.waiting) {
                                                                            return const Center(
                                                                              child: CircularProgressIndicator(),
                                                                            );
                                                                          }
                                                                          final user =
                                                                              snapshot.data;
                                                                          return IconButton
                                                                              .filled(
                                                                            tooltip:
                                                                                'Delete',
                                                                            hoverColor:
                                                                                Colors.red,
                                                                            icon:
                                                                                const Icon(Icons.delete),
                                                                            color:
                                                                                Colors.white,
                                                                            onPressed:
                                                                                () {
                                                                              String productId = cartProduct['productId'];
                                                                              context.read<UpdateUserInfoBloc>().add(
                                                                                    DeleteCartProducts(
                                                                                      user!.copyWith(
                                                                                        cartProducts: user.cartProducts!..removeAt(index),
                                                                                      ),
                                                                                      productId,
                                                                                    ),
                                                                                  );
                                                                              setState(() {});

                                                                              // Remove product from cart
                                                                            },
                                                                          );
                                                                        });
                                                                  });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            }),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: 700,
                                width: 270,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // Add this Column
                                    children: [
                                      const SizedBox(height: 20),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text(
                                          'CART SUMMARY',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 20),
                                      StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(context
                                                .read<AuthenticationBloc>()
                                                .state
                                                .user!
                                                .uid)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return const Text(
                                                'Something went wrong');
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }

                                          final cartProducts =
                                              (snapshot.data!.data() as Map<
                                                      String,
                                                      dynamic>)['cartProducts']
                                                  as List<dynamic>?;

                                          double totalPrice = 0;
                                          if (cartProducts != null) {
                                            for (var product in cartProducts) {
                                              totalPrice += (product['price']
                                                      as double) *
                                                  (product['quantity'] as int);
                                            }
                                          }

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('Subtotal:'),
                                                    Text(
                                                        'Ksh ${totalPrice.toStringAsFixed(2)}'),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                const Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Shipping:'),
                                                    Text('Ksh 0.00'),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Text('Total:'),
                                                    Text(
                                                        'Ksh ${totalPrice.toStringAsFixed(2)}'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(child: CheckoutButton())
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(context
                                        .read<AuthenticationBloc>()
                                        .state
                                        .user!
                                        .uid)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Something went wrong');
                                  } else if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  final cartProducts = (snapshot.data!.data()
                                          as Map<String, dynamic>)[
                                      'cartProducts'] as List<dynamic>?;

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cartProducts!.length,
                                    itemBuilder: (context, index) {
                                      final cartproduct = cartProducts[index];
                                      return Container(
                                        height: 130,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Card(
                                          surfaceTintColor: Colors.transparent,
                                          color: Colors.grey[200],
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    cartproduct['imageUrl'][0],
                                                    fit: BoxFit.cover,
                                                    width: 170,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 130,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(cartproduct[
                                                            'name']),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              'Ksh ${(cartproduct['price'] * cartproduct['quantity']).toString()}',
                                                              style:
                                                                  const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      BlocBuilder<
                                                          UpdateUserInfoBloc,
                                                          UpdateUserInfoState>(
                                                        builder:
                                                            (context, state) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Transform.scale(
                                                                scale: 0.7,
                                                                child: IconButton
                                                                    .outlined(
                                                                  icon: const Icon(
                                                                      CupertinoIcons
                                                                          .minus),
                                                                  onPressed:
                                                                      () async {
                                                                    if (cartproduct[
                                                                            'quantity'] >
                                                                        1) {
                                                                      // Decrease quantity
                                                                      cartproduct[
                                                                          'quantity'] -= 1;

                                                                      final userDoc = FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              'users')
                                                                          .doc(context
                                                                              .read<AuthenticationBloc>()
                                                                              .state
                                                                              .user!
                                                                              .uid);
                                                                      final userSnapshot =
                                                                          await userDoc
                                                                              .get();
                                                                      final userCartProducts = (userSnapshot
                                                                              .data()
                                                                          as Map<
                                                                              String,
                                                                              dynamic>)['cartProducts'] as List<
                                                                          dynamic>;

                                                                      final existingProductIndex = userCartProducts.indexWhere((product) =>
                                                                          product[
                                                                              'productId'] ==
                                                                          cartproduct[
                                                                              'productId']);
                                                                      if (existingProductIndex !=
                                                                          -1) {
                                                                        // Update the quantity of the existing product
                                                                        userCartProducts[existingProductIndex]['quantity'] =
                                                                            cartproduct['quantity'];
                                                                      }

                                                                      await userDoc
                                                                          .update({
                                                                        'cartProducts':
                                                                            userCartProducts,
                                                                      });
                                                                    }
                                                                    // Increase quantity
                                                                  },
                                                                ),
                                                              ),
                                                              StreamBuilder<
                                                                      DocumentSnapshot>(
                                                                  stream: FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          'users')
                                                                      .doc(context
                                                                          .read<
                                                                              AuthenticationBloc>()
                                                                          .state
                                                                          .user!
                                                                          .uid)
                                                                      .snapshots(),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasError) {
                                                                      log(snapshot
                                                                          .error
                                                                          .toString());
                                                                    } else if (snapshot
                                                                        .hasData) {
                                                                      final cartProducts = (snapshot
                                                                              .data!
                                                                              .data()
                                                                          as Map<
                                                                              String,
                                                                              dynamic>)['cartProducts'] as List<
                                                                          dynamic>?;
                                                                      return Text(cartProducts![index]
                                                                              [
                                                                              'quantity']
                                                                          .toString());
                                                                    } else {
                                                                      return const SizedBox();
                                                                    }
                                                                    return const SizedBox();
                                                                  }),
                                                              Transform.scale(
                                                                scale: 0.7,
                                                                child: IconButton
                                                                    .outlined(
                                                                  icon: const Icon(
                                                                      CupertinoIcons
                                                                          .add),
                                                                  onPressed:
                                                                      () async {
                                                                    // Get the product to be added
                                                                    final cartproduct =
                                                                        cartProducts[
                                                                            index];
                                                                    cartproduct[
                                                                            'quantity'] =
                                                                        (cartproduct['quantity'] ??
                                                                                0) +
                                                                            1;

                                                                    final userDoc = FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(context
                                                                            .read<AuthenticationBloc>()
                                                                            .state
                                                                            .user!
                                                                            .uid);
                                                                    final userSnapshot =
                                                                        await userDoc
                                                                            .get();
                                                                    final userCartProducts = (userSnapshot
                                                                            .data()
                                                                        as Map<
                                                                            String,
                                                                            dynamic>)['cartProducts'] as List<
                                                                        dynamic>;

                                                                    final existingProductIndex = userCartProducts.indexWhere((product) =>
                                                                        product[
                                                                            'productId'] ==
                                                                        cartproduct[
                                                                            'productId']);
                                                                    if (existingProductIndex !=
                                                                        -1) {
                                                                      // If the product exists, update its quantity
                                                                      userCartProducts[existingProductIndex]
                                                                              [
                                                                              'quantity'] =
                                                                          cartproduct[
                                                                              'quantity'];
                                                                    } else {
                                                                      // If the product doesn't exist, add it to the cart
                                                                      userCartProducts
                                                                          .add(
                                                                              cartproduct);
                                                                    }

                                                                    await userDoc
                                                                        .update({
                                                                      'cartProducts':
                                                                          userCartProducts,
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              BlocBuilder<UpdateUserInfoBloc,
                                                  UpdateUserInfoState>(
                                                builder: (context, state) {
                                                  return StreamBuilder<
                                                          DocumentSnapshot>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(context
                                                              .read<
                                                                  AuthenticationBloc>()
                                                              .state
                                                              .user!
                                                              .uid)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasError) {
                                                          return const Text(
                                                              'Something went wrong');
                                                        } else if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                        final cartProducts = (snapshot
                                                                        .data!
                                                                        .data()
                                                                    as Map<String,
                                                                        dynamic>)[
                                                                'cartProducts']
                                                            as List<dynamic>?;
                                                        final cartProduct =
                                                            cartProducts![
                                                                index];
                                                        return StreamBuilder<
                                                                MyUser>(
                                                            stream: context
                                                                .read<
                                                                    FirebaseUserRepository>()
                                                                .userStream(context
                                                                    .read<
                                                                        AuthenticationBloc>()
                                                                    .state
                                                                    .user!
                                                                    .uid),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasError) {
                                                                return const Text(
                                                                    'Something went wrong');
                                                              } else if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return const Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              }
                                                              final user =
                                                                  snapshot.data;
                                                              return IconButton
                                                                  .filled(
                                                                tooltip:
                                                                    'Delete',
                                                                hoverColor:
                                                                    Colors.red,
                                                                icon: const Icon(
                                                                    Icons
                                                                        .delete),
                                                                color: Colors
                                                                    .white,
                                                                onPressed: () {
                                                                  String
                                                                      productId =
                                                                      cartProduct[
                                                                          'productId'];
                                                                  context
                                                                      .read<
                                                                          UpdateUserInfoBloc>()
                                                                      .add(
                                                                        DeleteCartProducts(
                                                                          user!
                                                                              .copyWith(
                                                                            cartProducts: user.cartProducts!
                                                                              ..removeAt(index),
                                                                          ),
                                                                          productId,
                                                                        ),
                                                                      );
                                                                  setState(
                                                                      () {});

                                                                  // Remove product from cart
                                                                },
                                                              );
                                                            });
                                                      });
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }),
                            const SizedBox(height: 20),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [CheckoutButton()]),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    } else {
                      return const Text('Something went wrong!');
                    }
                  },
                ),
              );
            } else {
              return WelcomeScreen();
            }
          },
        ),
      ),
    );
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(context.read<AuthenticationBloc>().state.user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final cartProducts = (snapshot.data!.data()
              as Map<String, dynamic>)['cartProducts'] as List<dynamic>?;
          double totalPrice = 0;
          if (cartProducts != null) {
            for (var product in cartProducts) {
              totalPrice +=
                  (product['price'] as double) * (product['quantity'] as int);
            }
          }

          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Theme.of(context).colorScheme.primary,
              minimumSize: const Size(200, 50), // Set the minimum height to 50
            ),
            child: Text(
              'CHECKOUT (KSH ${totalPrice.toStringAsFixed(2)})',
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: () {
              GoRouter.of(context).goNamed(RouteConstants.checkout);
              // Proceed to checkout
            },
          );
        });
  }
}

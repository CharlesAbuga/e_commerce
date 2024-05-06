import 'dart:developer';

import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBarSmall extends StatefulWidget {
  const AppBarSmall({super.key});

  @override
  State<AppBarSmall> createState() => _AppBarSmallState();
}

class _AppBarSmallState extends State<AppBarSmall> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return BlocProvider(
            create: (context) => MyUserBloc(
              myUserRepository:
                  context.read<AuthenticationBloc>().userRepository,
            )..add(GetMyUser(
                myUserId: context.read<AuthenticationBloc>().state.user!.uid)),
            child: BlocConsumer<MyUserBloc, MyUserState>(
              listener: (context, state) {
                if (state.status == MyUserStatus.success) {
                  context.read<MyUserBloc>().add(GetMyUser(
                      myUserId:
                          context.read<AuthenticationBloc>().state.user!.uid));
                } else if (state.status == MyUserStatus.failure) {
                  // Do something when the status is failure
                }
              },
              builder: (context, state) {
                if (state.status == MyUserStatus.loading) {
                  return AppBar(
                    surfaceTintColor: Colors.transparent,
                    elevation: 1,
                    shadowColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.search)),
                      badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            badgeGradient: badges.BadgeGradient.linear(
                                colors: [Colors.orange, Colors.yellow])),
                        position: badges.BadgePosition.custom(
                          top: -5,
                          end: 0.5,
                        ),
                        badgeAnimation: const badges.BadgeAnimation.slide(),
                        badgeContent: null,
                        child: IconButton(
                          onPressed: () {
                            GoRouter.of(context).goNamed(RouteConstants.cart);
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            size: 20,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.goNamed(RouteConstants.userProfile);
                        },
                        icon: const Icon(Icons.person),
                      ),
                    ],
                    title: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).goNamed(RouteConstants.home);
                        },
                        child: const Text('Home')),
                    centerTitle: true,
                  );
                } else if (state.status == MyUserStatus.success) {
                  return AppBar(
                    elevation: 7,
                    surfaceTintColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: Colors.grey[200],
                    actions: [
                      IconButton(
                          onPressed: () {
                            GoRouter.of(context)
                                .pushNamed(RouteConstants.search);
                          },
                          icon: const Icon(Icons.search)),
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: StreamBuilder<DocumentSnapshot>(
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
                                log(snapshot.error.toString());
                              }
                              if (snapshot.hasData) {
                                final cartProducts = (snapshot.data!.data()
                                        as Map<String, dynamic>)['cartProducts']
                                    as List<dynamic>?;
                                return badges.Badge(
                                  badgeStyle: const badges.BadgeStyle(
                                      badgeGradient:
                                          badges.BadgeGradient.linear(colors: [
                                    Colors.orange,
                                    Colors.yellow
                                  ])),
                                  position: badges.BadgePosition.custom(
                                    top: -5,
                                    end: 0.5,
                                  ),
                                  badgeAnimation:
                                      const badges.BadgeAnimation.fade(),
                                  badgeContent:
                                      Text(cartProducts!.length.toString()),
                                  child: IconButton(
                                    onPressed: () {
                                      GoRouter.of(context)
                                          .goNamed(RouteConstants.cart);
                                    },
                                    icon: const Icon(
                                      Icons.shopping_cart,
                                      size: 20,
                                    ),
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }),
                      ),
                    ],
                    title: GestureDetector(
                        onTap: () {
                          GoRouter.of(context).goNamed(RouteConstants.home);
                        },
                        child: const Text('Home')),
                    centerTitle: true,
                  );
                }
                return const SizedBox();
              },
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

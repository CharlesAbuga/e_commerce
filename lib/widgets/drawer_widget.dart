import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/bloc/sign_in/sign_in_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return BlocProvider(
          create: (context) => MyUserBloc(
              myUserRepository:
                  context.read<AuthenticationBloc>().userRepository)
            ..add(
              GetMyUser(
                  myUserId: context.read<AuthenticationBloc>().state.user!.uid),
            ),
          child: BlocBuilder<MyUserBloc, MyUserState>(
            builder: (context, state) {
              if (state.status == MyUserStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.status == MyUserStatus.success) {
                return Drawer(
                    surfaceTintColor: Colors.white,
                    backgroundColor: Colors.white,
                    child: ListView(
                      children: [
                        const DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.black,
                          ),
                          child: Text('Drawer Header'),
                        ),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                GoRouter.of(context)
                                    .goNamed(RouteConstants.userProfile);
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 25,
                                backgroundImage: NetworkImage(
                                    scale: 1,
                                    context
                                                .read<MyUserBloc>()
                                                .state
                                                .user!
                                                .profilePicture !=
                                            null
                                        ? context
                                            .read<MyUserBloc>()
                                            .state
                                            .user!
                                            .profilePicture!
                                        : 'assets/images/account.png'),
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              const Text('Welcome back',
                                  style: TextStyle(fontSize: 16)),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                context.read<MyUserBloc>().state.user!.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 0.1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: ThemeData(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                childrenPadding: const EdgeInsets.all(8),
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                title: const Text('Men'),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/shoe-1-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text('Shoes',
                                          style: TextStyle(fontSize: 14)),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to shoes for men
                                        GoRouter.of(context)
                                            .goNamed(RouteConstants.mensShoes);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/reshot-icon-jeans-XLD58F3HEU.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text('Clothing',
                                          style: TextStyle(fontSize: 14)),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to clothing for men
                                        GoRouter.of(context).goNamed(
                                            RouteConstants.mensClothes);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/belt-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text('Accessories',
                                          style: TextStyle(fontSize: 14)),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to clothing for men
                                        GoRouter.of(context).goNamed(
                                            RouteConstants.mensAccessories);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 0.1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: ThemeData(
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                childrenPadding: const EdgeInsets.all(8),
                                visualDensity:
                                    VisualDensity.adaptivePlatformDensity,
                                title: const Text('Women'),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/shoe-with-high-heel-shoe-heel-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text('Shoes',
                                          style: TextStyle(fontSize: 14)),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to shoes for women
                                        GoRouter.of(context).goNamed(
                                            RouteConstants.womensShoes);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/dress-4-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text(
                                        'Clothing',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to clothing for women
                                        GoRouter.of(context).goNamed(
                                            RouteConstants.womensClothes);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/necklace-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text(
                                        'Accessories',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to clothing for women
                                        GoRouter.of(context).goNamed(
                                            RouteConstants.womensAccessories);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 0.1,
                                  blurRadius: 0.1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Theme(
                              data: ThemeData(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                dividerColor: Colors.transparent,
                              ),
                              child: ExpansionTile(
                                childrenPadding: const EdgeInsets.all(8),
                                title: const Text('Children'),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/baby-shoes-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text('Shoes',
                                          style: TextStyle(fontSize: 14)),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to shoes for children
                                        GoRouter.of(context)
                                            .goNamed(RouteConstants.babyShoes);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/baby-boy-clothes-with-anchor-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text('Clothing',
                                          style: TextStyle(fontSize: 14)),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to clothing for children
                                        GoRouter.of(context).goNamed(
                                            RouteConstants.babyClothes);
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      leading: SvgPicture.asset(
                                          'assets/images/play-time-baby-toy-svgrepo-com.svg',
                                          height: 24,
                                          width: 24),
                                      title: const Text('Accessories',
                                          style: TextStyle(fontSize: 14)),
                                      trailing: const Icon(
                                          CupertinoIcons.right_chevron,
                                          size: 14),
                                      onTap: () {
                                        // Handle navigation to clothing for children
                                        GoRouter.of(context).goNamed(
                                            RouteConstants.babyAccessories);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Divider(),
                        const SizedBox(height: 145),
                        Theme(
                          data: ThemeData(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                GoRouter.of(context)
                                    .goNamed(RouteConstants.savedProducts);
                              },
                              child: const Text(
                                'SAVED PRODUCTS',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<SignInBloc>()
                                  .add(const SignOutRequired());
                            },
                            child: const Text(
                              'LOG OUT',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ));
              } else {
                return const Text('An error occurred');
              }
            },
          ),
        );
      },
    );
  }
}

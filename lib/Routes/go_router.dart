import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/authentication/authentication_bloc.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/bloc/my_user/my_user_bloc.dart';
import 'package:ecommerce_app/screens/admin_screen.dart';
import 'package:ecommerce_app/screens/admin_update.dart';
import 'package:ecommerce_app/screens/baby_accessories.dart';
import 'package:ecommerce_app/screens/baby_clothes.dart';
import 'package:ecommerce_app/screens/baby_shoes.dart';
import 'package:ecommerce_app/screens/checkout.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/men.dart';
import 'package:ecommerce_app/screens/mens_accessories.dart';
import 'package:ecommerce_app/screens/mens_clothes.dart';
import 'package:ecommerce_app/screens/mens_shoes.dart';
import 'package:ecommerce_app/screens/my_cart.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/screens/saved_products.dart';
import 'package:ecommerce_app/screens/search.dart';
import 'package:ecommerce_app/screens/user_profile.dart';
import 'package:ecommerce_app/screens/womens_accessories.dart';
import 'package:ecommerce_app/screens/womens_clothes.dart';
import 'package:ecommerce_app/screens/womens_shoes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repository/product_repository.dart';
import 'package:user_repository/user_repository.dart';

class AppRouter {
  late final GoRouter router;
  AppRouter() {
    // myUserBloc = MyUserBloc(myUserRepository: FirebaseUserRepository())
    //   ..add(GetMyUser(myUserId: FirebaseAuth.instance.currentUser!.uid));
    // getProductBloc =
    //     GetProductBloc(productRepository: FirebaseProductRepository())
    //       ..add(const GetProduct());

    router = GoRouter(initialLocation: '/', routes: [
      GoRoute(
        path: '/',
        name: RouteConstants.home,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
      GoRoute(
        path: '/mens',
        name: RouteConstants.mens,
        pageBuilder: (context, state) {
          return const MaterialPage(child: Men());
        },
      ),
      GoRoute(
        name: RouteConstants.savedProducts,
        path: '/savedProducts',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: SavedProducts());
        },
      ),
      GoRoute(
        name: RouteConstants.cart,
        path: '/cart',
        pageBuilder: (context, state) {
          // final myUserBloc = MyUserBloc(
          //     myUserRepository: FirebaseUserRepository())
          //   ..add(GetMyUser(myUserId: FirebaseAuth.instance.currentUser!.uid));
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          return const MaterialPage(child: MyCart());
        },
      ),
      GoRoute(
        name: RouteConstants.search,
        path: '/search',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          return const MaterialPage(child: Search());
        },
      ),
      GoRoute(
        name: RouteConstants.checkout,
        path: '/checkout',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          return const MaterialPage(child: CheckOut());
        },
      ),
      GoRoute(
        name: RouteConstants.details,
        path: '/details/:productId',
        pageBuilder: (context, state) {
          // final getProductBloc =
          //     GetProductBloc(productRepository: FirebaseProductRepository())
          //       ..add(const GetProduct());
          // final myUserBloc = MyUserBloc(
          //     myUserRepository: FirebaseUserRepository())
          //   ..add(GetMyUser(myUserId: FirebaseAuth.instance.currentUser!.uid));
          final productId = state.pathParameters['productId'];
          // getProductBloc.add(const GetProduct());
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          return MaterialPage(
            child: ProductDetail(productId: productId!),
          );
        },
      ),
      GoRoute(
        name: RouteConstants.admin,
        path: '/admin',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: AdminScreen());
        },
      ),
      GoRoute(
        name: RouteConstants.adminUpdate,
        path: '/adminUpdate',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: AdminUpdatePage());
        },
      ),
      GoRoute(
        name: RouteConstants.babyClothes,
        path: '/babyClothes',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: BabyClothes());
        },
      ),
      GoRoute(
        name: RouteConstants.babyShoes,
        path: '/babyShoes',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: BabyShoes());
        },
      ),
      GoRoute(
        name: RouteConstants.babyAccessories,
        path: '/babyAccessories',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: BabyAccessories());
        },
      ),
      GoRoute(
        name: RouteConstants.mensAccessories,
        path: '/mensAccessories',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: MensAccessories());
        },
      ),
      GoRoute(
        name: RouteConstants.mensShoes,
        path: '/mensShoes',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: MensShoes());
        },
      ),
      GoRoute(
        name: RouteConstants.mensClothes,
        path: '/mensClothes',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: MensClothes());
        },
      ),
      GoRoute(
        name: RouteConstants.womensClothes,
        path: '/womensClothes',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: WomensClothes());
        },
      ),
      GoRoute(
        name: RouteConstants.womensShoes,
        path: '/womensShoes',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: WomensShoes());
        },
      ),
      GoRoute(
        name: RouteConstants.womensAccessories,
        path: '/womensAccessories',
        pageBuilder: (context, state) {
          // myUserBloc.add(GetMyUser(
          //     myUserId: context.read<AuthenticationBloc>().state.user!.uid));
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: WomensAccessories());
        },
      ),
      GoRoute(
        name: RouteConstants.userProfile,
        path: '/userProfile',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: UserProfile());
        },
      ),
    ]);
  }
}

import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/bloc/get_product_bloc/get_product_bloc.dart';
import 'package:ecommerce_app/product_class.dart';
import 'package:ecommerce_app/screens/admin_screen.dart';
import 'package:ecommerce_app/screens/baby_accessories.dart';
import 'package:ecommerce_app/screens/baby_clothes.dart';
import 'package:ecommerce_app/screens/baby_shoes.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/men.dart';
import 'package:ecommerce_app/screens/mens_accessories.dart';
import 'package:ecommerce_app/screens/mens_clothes.dart';
import 'package:ecommerce_app/screens/mens_shoes.dart';
import 'package:ecommerce_app/screens/my_cart.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:ecommerce_app/screens/womens_accessories.dart';
import 'package:ecommerce_app/screens/womens_clothes.dart';
import 'package:ecommerce_app/screens/womens_shoes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:product_repository/product_repository.dart';

class AppRouter {
  late final GetProductBloc getProductBloc;
  late final GoRouter router;
  AppRouter() {
    getProductBloc =
        GetProductBloc(productRepository: FirebaseProductRepository())
          ..add(GetProduct());
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
        name: RouteConstants.cart,
        path: '/cart',
        pageBuilder: (context, state) {
          return const MaterialPage(child: MyCart());
        },
      ),
      GoRoute(
        name: RouteConstants.details,
        path: '/details/:productId',
        pageBuilder: (context, state) {
          final productId = state.pathParameters['productId'];
          getProductBloc.add(GetProduct());
          return MaterialPage(
              child: BlocProvider.value(
            value: getProductBloc,
            child: BlocBuilder<GetProductBloc, GetProductState>(
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
                  final product = state.products
                      .firstWhere((element) => element.productId == productId);
                  return ProductDetail(productId: product.productId);
                } else {
                  return const Center(
                    child: Text('Failed to fetch products'),
                  );
                }
              },
            ),
          ));
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
        name: RouteConstants.babyClothes,
        path: '/babyClothes',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: BabyClothes());
        },
      ),
      GoRoute(
        name: RouteConstants.babyShoes,
        path: '/babyShoes',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: BabyShoes());
        },
      ),
      GoRoute(
        name: RouteConstants.babyAccessories,
        path: '/babyAccessories',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: BabyAccessories());
        },
      ),
      GoRoute(
        name: RouteConstants.mensAccessories,
        path: '/mensAccessories',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: MensAccessories());
        },
      ),
      GoRoute(
        name: RouteConstants.mensShoes,
        path: '/mensShoes',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: MensShoes());
        },
      ),
      GoRoute(
        name: RouteConstants.mensClothes,
        path: '/mensClothes',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: MensClothes());
        },
      ),
      GoRoute(
        name: RouteConstants.womensClothes,
        path: '/womensClothes',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: WomensClothes());
        },
      ),
      GoRoute(
        name: RouteConstants.womensShoes,
        path: '/womensShoes',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: WomensShoes());
        },
      ),
      GoRoute(
        name: RouteConstants.womensAccessories,
        path: '/womensAccessories',
        pageBuilder: (context, state) {
          // Replace `AdminScreen` with the actual screen widget for the admin page
          return const MaterialPage(child: WomensAccessories());
        },
      ),
    ]);
  }
}

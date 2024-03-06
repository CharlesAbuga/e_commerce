import 'package:ecommerce_app/Routes/router_constants.dart';
import 'package:ecommerce_app/product_class.dart';
import 'package:ecommerce_app/screens/home_page.dart';
import 'package:ecommerce_app/screens/my_cart.dart';
import 'package:ecommerce_app/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce_app/conv.dart';

class AppRouter {
  GoRouter router = GoRouter(initialLocation: '/', routes: [
    GoRoute(
      name: RouteConstants.home,
      path: '/',
      pageBuilder: (context, state) {
        return MaterialPage(child: HomePage(products: productList));
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
        Product product = state.extra as Product;
        return MaterialPage(child: ProductDetail(product: product));
      },
    ),
  ]);
}

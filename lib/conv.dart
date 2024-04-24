/* import 'package:ecommerce_app/global_variables.dart';
import 'package:ecommerce_app/product_class.dart';
import 'package:flutter/material.dart';

List<Product> productList = products
    .map(
      (productData) => Product(
          productId: productData['id'].toString(),
          title: productData['title'].toString(),
          price: productData['price'].toString(),
          imageUrl: (productData['imageUrl'] as List<dynamic>)
              .map((url) => url.toString())
              .toList(),
          sizes: (productData['sizes'] as List<dynamic>)
              .map((url) => url.toString())
              .toList(),
          colors: productData['colors'] as List<Color>),
    )
    .toList(); */

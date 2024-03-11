import 'package:flutter/material.dart';

class Product {
  final String title;
  final List<String> imageUrl;
  final String price;
  final String productId;
  final List<String> sizes;
  final List<Color> colors;

  Product(
      {required this.colors,
      required this.productId,
      required this.sizes,
      required this.title,
      required this.imageUrl,
      required this.price});
}

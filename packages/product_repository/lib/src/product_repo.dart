import 'dart:io';

import 'package:product_repository/product_repository.dart';

abstract class ProductRepository {
  Future<Product> createProduct(Product product);
  Future<List<Product>> getProduct();
}

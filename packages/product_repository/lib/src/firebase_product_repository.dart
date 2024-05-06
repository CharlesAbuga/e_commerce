import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_repository/product_repository.dart';
import 'package:uuid/uuid.dart';

class FirebaseProductRepository implements ProductRepository {
  final productCollection = FirebaseFirestore.instance.collection('products');
  @override
  Future<Product> createProduct(Product product) async {
    try {
      product.productId = const Uuid().v1();
      product.createdAt = DateTime.now();

      // Get the download URL and store it in the product
      // Assuming imageUrl is a list of strings
      await productCollection
          .doc(product.productId)
          .set(product.toEntity().toDocument());
      return product;
    } on FirebaseException catch (e) {
      log(e.toString());
      log(e.message.toString());
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProduct() {
    try {
      return productCollection.get().then((value) {
        return value.docs
            .map((doc) =>
                Product.fromEntity(ProductEntity.fromDocument(doc.data())))
            .toList();
      });
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    try {
      await productCollection
          .doc(product.productId)
          .update(product.toEntity().toDocument());
    } on FirebaseException catch (e) {
      log(e.toString());
      log(e.message.toString());
      rethrow;
    }
  }
}

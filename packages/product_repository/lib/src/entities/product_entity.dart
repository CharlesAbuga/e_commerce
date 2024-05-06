import 'package:cloud_firestore/cloud_firestore.dart';

class ProductEntity {
  final String productId;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> size;
  final List<String> color;
  final int stock;
  final String ageGroup;
  final String gender; // Use the enum here
  final List<String> imageUrl;
  final DateTime createdAt;

  ProductEntity({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.size,
    required this.color,
    required this.stock,
    required this.ageGroup,
    required this.gender,
    required this.imageUrl,
    required this.createdAt,
  });

  Map<String, Object?> toDocument() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'size': size,
      'color': color,
      'stock': stock,
      'gender': gender,
      'ageGroup': ageGroup,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }

  static ProductEntity fromDocument(Map<String, dynamic> doc) {
    return ProductEntity(
      productId: doc['productId'] as String,
      name: doc['name'] as String,
      description: doc['description'] as String,
      price: doc['price'] as double,
      category: doc['category'] as String,
      size: (doc['size'] as List).cast<String>(),
      color: (doc['color'] as List).cast<String>(),
      stock: doc['stock'] as int,
      gender: doc['gender'] as String,
      ageGroup: doc['ageGroup'] as String,
      imageUrl: (doc['imageUrl'] as List).cast<String>(),
      createdAt: doc['creationDate'] != null
          ? (doc['creationDate'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  @override
  String toString() {
    return '''
      ProductEntity {
        productId: $productId,
        name: $name,
        description: $description,
        price: $price,
        category: $category,
        size: $size,
        color: $color,
        stock: $stock,
        ageGroup: $ageGroup,
        gender: $gender,
        imageUrl: $imageUrl,
        createdAt: $createdAt,
      }
    ''';
  }
}

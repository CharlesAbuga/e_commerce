import 'package:product_repository/src/entities/product_entity.dart';

class Product {
  final String productId;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> size;
  final List<String> color;
  final int stock;
  final String ageGroup;
  final String gender;
  final List<String> imageUrl;

  Product({
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
  });

  static var empty = Product(
    ageGroup: '',
    productId: '',
    name: '',
    description: '',
    price: 0,
    category: '',
    size: [],
    color: [],
    stock: 0,
    gender: '',
    imageUrl: [],
  );

  Product copyWith({
    String? productId,
    String? name,
    String? description,
    double? price,
    String? category,
    List<String>? size,
    List<String>? color,
    int? stock,
    String? ageGroup,
    String? gender,
    List<String>? imageUrl,
  }) {
    return Product(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      size: size ?? this.size,
      color: color ?? this.color,
      stock: stock ?? this.stock,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  bool get isEmpty => this == Product.empty;

  bool get isNotEmpty => this != Product.empty;

  ProductEntity toEntity() {
    return ProductEntity(
      productId: productId,
      name: name,
      description: description,
      price: price,
      category: category,
      size: size,
      color: color,
      stock: stock,
      gender: gender,
      ageGroup: ageGroup,
      imageUrl: imageUrl,
    );
  }

  static Product fromEntity(ProductEntity entity) {
    return Product(
      productId: entity.productId,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      category: entity.category,
      size: entity.size,
      color: entity.color,
      stock: entity.stock,
      gender: entity.gender,
      ageGroup: entity.ageGroup,
      imageUrl: entity.imageUrl,
    );
  }
}

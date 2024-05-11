import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? addressLine1;
  final String? streetAddress;
  final String? city;
  final String? postalCode;
  final String? profilePicture;
  final List<Map<String, dynamic>>? savedProducts;
  final List<Map<String, dynamic>>? cartProducts;

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.addressLine1,
    this.streetAddress,
    this.city,
    this.postalCode,
    this.profilePicture,
    this.savedProducts,
    this.cartProducts,
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'addressLine1': addressLine1,
      'addressLine2': streetAddress,
      'city': city,
      'postalCode': postalCode,
      'profilePicture': profilePicture,
      'savedProducts': savedProducts,
      'cartProducts': cartProducts?.map((product) {
        return {
          ...product,
          'quantity': product['quantity'] ?? 1, // Add quantity to each product
        };
      }).toList(),
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      addressLine1: doc['addressLine1'] as String?,
      streetAddress: doc['addressLine2'] as String?,
      city: doc['city'] as String?,
      postalCode: doc['postalCode'] as String?,
      profilePicture: doc['profilePicture'] as String?,
      savedProducts: (doc['savedProducts'] as List<dynamic>?)
          ?.cast<Map<String, dynamic>>(),
      cartProducts: (doc['cartProducts'] as List<dynamic>?)
          ?.map((product) => product as Map<String, dynamic>)
          .toList(),
    );
  }

  @override
  // implement props
  List<Object?> get props => [
        id,
        name,
        email,
        addressLine1,
        streetAddress,
        city,
        postalCode,
        profilePicture,
        savedProducts,
        cartProducts,
      ];

  @override
  String toString() {
    return '''MyUserEntity: {
      id: $id,
      email: $email,
      name: $name,
      addressLine1: $addressLine1,
      addressLine2: $streetAddress,
      city: $city,
      postalCode: $postalCode,
      profilePicture: $profilePicture,
      savedProducts: $savedProducts,
      cartProducts: $cartProducts,
     
    }''';
  }
}

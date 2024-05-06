import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? postalCode;
  final String? profilePicture;
  final List<Map<String, dynamic>>? savedProducts;
  final List<Map<String, dynamic>>? cartProducts;

  const MyUser({
    required this.id,
    required this.email,
    required this.name,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.postalCode,
    this.profilePicture,
    this.savedProducts,
    this.cartProducts,
  });

  static const empty = MyUser(
    id: '',
    email: '',
    name: '',
    savedProducts: [],
    cartProducts: [],
    addressLine1: '',
    addressLine2: '',
    city: '',
    postalCode: '',
    profilePicture: '',
  );

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? addressLine1,
    String? addressLine2,
    String? city,
    String? postalCode,
    String? profilePicture,
    List<Map<String, dynamic>>? savedProducts,
    List<Map<String, dynamic>>? cartProducts,
    int? cartItemcount,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      addressLine1: addressLine1 ?? this.addressLine1,
      addressLine2: addressLine2 ?? this.addressLine2,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      profilePicture: profilePicture ?? this.profilePicture,
      savedProducts: savedProducts ?? this.savedProducts,
      cartProducts: cartProducts ?? this.cartProducts,
    );
  }

  bool get isEmpty => this == MyUser.empty;

  bool get isNotEmpty => this != MyUser.empty;

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      city: city,
      postalCode: postalCode,
      profilePicture: profilePicture,
      savedProducts: savedProducts,
      cartProducts: cartProducts,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      addressLine1: entity.addressLine1,
      addressLine2: entity.addressLine2,
      city: entity.city,
      postalCode: entity.postalCode,
      profilePicture: entity.profilePicture,
      savedProducts: entity.savedProducts,
      cartProducts: entity.cartProducts,
    );
  }

  @override
  // implement props
  List<Object?> get props => [
        id,
        email,
        name,
        addressLine1,
        addressLine2,
        city,
        postalCode,
        profilePicture,
        savedProducts,
        cartProducts,
      ];
}

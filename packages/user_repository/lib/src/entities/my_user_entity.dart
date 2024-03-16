import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;

  const MyUserEntity(
      {required this.id, required this.email, required this.name});

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, email];

  @override
  String toString() {
    return '''MyUserEntity: {
      id: $id,
      email: $email,
      name: $name,
    }''';
  }
}

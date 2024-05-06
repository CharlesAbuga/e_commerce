import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/my_user.dart';
import 'package:user_repository/src/user_repo.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseUserRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser> userStream(String userId) {
    return userCollection.doc(userId).snapshots().map((snapshot) {
      if (snapshot.exists == false) {}
      return MyUser.fromEntity(MyUserEntity.fromDocument(snapshot.data()!));
    });
  }

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      return user;
    });
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: myUser.email, password: password);

      myUser = myUser.copyWith(id: user.user!.uid);

      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      return userCollection
          .doc(myUserId)
          .get()
          .then((value) => MyUser.fromEntity(
                MyUserEntity.fromDocument(value.data()!),
              ));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await userCollection.doc(user.id).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());

      rethrow;
    }
  }

  @override
  Future<void> updateUserData(MyUser user) async {
    try {
      await userCollection.doc(user.id).update(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> addSavedProduct(
      MyUser user, Map<String, dynamic> productToAdd) async {
    try {
      final docRef = userCollection.doc(user.id);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        final currentUser = MyUserEntity.fromDocument(
            docSnapshot.data() as Map<String, dynamic>);
        final updatedSavedProducts =
            List<Map<String, dynamic>>.from(currentUser.savedProducts ?? []);
        updatedSavedProducts.add(productToAdd);
        final updatedUser = user.copyWith(savedProducts: updatedSavedProducts);
        await docRef.update(updatedUser.toEntity().toDocument());
      } else {
        final newUser = user.copyWith(savedProducts: [productToAdd]);
        await docRef.set(newUser.toEntity().toDocument());
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteCartProduct(MyUser user, String productId) async {
    try {
      await userCollection
          .doc(user.id)
          .collection('cartProducts')
          .doc(productId)
          .delete()
          .whenComplete(() => log('Product deleted'));
      await userCollection.doc(user.id).update(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteSavedProduct(MyUser user, String productId) async {
    try {
      log('Deleting product with ID: $productId');
      await userCollection
          .doc(user.id)
          .collection('savedProducts')
          .doc(productId)
          .delete()
          .whenComplete(() => log('Product deleted from saved products'));
      await userCollection.doc(user.id).update(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

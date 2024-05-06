import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_repository/user_repository.dart';

abstract class UserRepository {
  Stream<User?> get user;
  Future<MyUser> signUp(MyUser myUser, String password);
  Future<void> signIn(String email, String password);
  Future<void> logOut();
  Future<void> resetPassword(String email);
  Future<void> setUserData(MyUser user);
  Future<MyUser> getMyUser(String myUserId);
  Future<void> updateUserData(MyUser user);
  Future<void> deleteCartProduct(MyUser user, String productId);
  Future<void> deleteSavedProduct(MyUser user, String productId);
  Future<void> addSavedProduct(MyUser user, Map<String, dynamic> productToAdd);
  Stream<MyUser> userStream(String userId);
}

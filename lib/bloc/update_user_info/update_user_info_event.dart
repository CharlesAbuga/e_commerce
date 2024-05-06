part of 'update_user_info_bloc.dart';

abstract class UpdateUserInfoEvent extends Equatable {
  const UpdateUserInfoEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserInfoRequired extends UpdateUserInfoEvent {
  final MyUser user;

  const UpdateUserInfoRequired(this.user);
}

class DeleteCartProducts extends UpdateUserInfoEvent {
  final MyUser user;
  final String productId;
  const DeleteCartProducts(this.user, this.productId);

  @override
  List<Object> get props => [user];
}

class DeleteSavedProducts extends UpdateUserInfoEvent {
  final MyUser user;
  final String productId;
  const DeleteSavedProducts(this.user, this.productId);

  @override
  List<Object> get props => [user];
}

class AddSavedProducts extends UpdateUserInfoEvent {
  final MyUser user;
  final Map<String, dynamic> productToAdd;

  const AddSavedProducts(this.user, this.productToAdd);

  @override
  List<Object> get props => [user];
}

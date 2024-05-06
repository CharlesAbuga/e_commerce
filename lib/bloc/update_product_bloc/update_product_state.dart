part of 'update_product_bloc.dart';

sealed class UpdateProductState extends Equatable {
  const UpdateProductState();

  @override
  List<Object> get props => [];
}

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductFailure extends UpdateProductState {}

final class UpdateProductLoading extends UpdateProductState {}

final class UpdateProductSuccess extends UpdateProductState {
  final Product product;

  const UpdateProductSuccess({required this.product});

  @override
  List<Object> get props => [product];
}

part of 'create_product_bloc.dart';

sealed class CreateProductState extends Equatable {
  const CreateProductState();

  @override
  List<Object> get props => [];
}

final class CreateProductInitial extends CreateProductState {}

final class CreateProductFailure extends CreateProductState {}

final class CreateProductLoading extends CreateProductState {}

final class CreateProductSuccess extends CreateProductState {
  final Product product;

  const CreateProductSuccess({required this.product});
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  final ProductRepository _productRepository;
  CreateProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(CreateProductInitial()) {
    on<CreateProduct>((event, emit) async {
      emit(CreateProductLoading());
      try {
        Product product = await _productRepository.createProduct(event.product);
        emit(CreateProductSuccess(product: product));
      } catch (e) {
        emit(CreateProductFailure());
        rethrow;
      }
    });
  }
}

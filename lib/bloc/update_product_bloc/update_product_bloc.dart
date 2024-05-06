import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:product_repository/product_repository.dart';

part 'update_product_event.dart';
part 'update_product_state.dart';

class UpdateProductBloc extends Bloc<UpdateProductEvent, UpdateProductState> {
  final ProductRepository _productRepository;
  UpdateProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(UpdateProductInitial()) {
    on<UpdateProduct>((event, emit) async {
      emit(UpdateProductLoading());
      try {
        await _productRepository.updateProduct(event.product);
        emit(UpdateProductSuccess(product: event.product));
      } catch (e) {
        emit(UpdateProductFailure());
        log(e.toString());
        rethrow;
      }
    });
  }
}

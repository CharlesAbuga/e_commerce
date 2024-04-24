import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:product_repository/product_repository.dart';

part 'get_product_event.dart';
part 'get_product_state.dart';

class GetProductBloc extends Bloc<GetProductEvent, GetProductState> {
  final ProductRepository _productRepository;
  GetProductBloc({
    required ProductRepository productRepository,
  })  : _productRepository = productRepository,
        super(GetProductInitial()) {
    on<GetProduct>((event, emit) async {
      emit(GetProductLoading());
      try {
        List<Product> products = await _productRepository.getProduct();
        emit(GetProductSuccess(products: products));
      } on FirebaseException catch (e) {
        emit(GetProductFailure());
        print(e.message.toString());
      }
    });
  }
}

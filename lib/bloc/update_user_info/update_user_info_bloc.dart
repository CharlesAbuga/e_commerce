import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_info_event.dart';
part 'update_user_info_state.dart';

class UpdateUserInfoBloc
    extends Bloc<UpdateUserInfoEvent, UpdateUserInfoState> {
  final UserRepository _userRepository;

  UpdateUserInfoBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UpdateUserInfoInitial()) {
    on<UpdateUserInfoRequired>((event, emit) async {
      emit(UpdateUserInfoLoading());
      try {
        await _userRepository.updateUserData(event.user);

        emit(UpdateUserInfoSuccess());
      } catch (e) {
        emit(UpdateUserInfoFailure());
      }
    });

    on<DeleteCartProducts>((event, emit) async {
      emit(UpdateUserInfoLoading());
      try {
        await _userRepository.deleteCartProduct(event.user, event.productId);

        emit(UpdateUserInfoSuccess());
      } catch (e) {
        emit(UpdateUserInfoFailure());
      }
    });
    on<DeleteSavedProducts>((event, emit) async {
      emit(UpdateUserInfoLoading());
      try {
        await _userRepository.deleteSavedProduct(event.user, event.productId);

        emit(UpdateUserInfoSuccess());
      } catch (e) {
        emit(UpdateUserInfoFailure());
      }
    });
    on<AddSavedProducts>((event, emit) async {
      emit(UpdateUserInfoLoading());
      try {
        await _userRepository.addSavedProduct(event.user, event.productToAdd);

        emit(UpdateUserInfoSuccess());
      } catch (e) {
        emit(UpdateUserInfoFailure());
      }
    });
  }
}

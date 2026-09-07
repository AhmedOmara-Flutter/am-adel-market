import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/repos/order_repo/order_repo.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/entities/order_entity.dart';
import 'package:meta/meta.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._orderRepo, this._authRepo) : super(ProfileInitial());
  final OrderRepo _orderRepo;
  final AuthRepo _authRepo;
  bool obscureText = true;
  StreamSubscription ?_orderSubscription;

  void changeObscureText() {
    obscureText = !obscureText;
    emit(ProfileChangeObscureText());
  }

 void getOrders()  {
   _orderSubscription?.cancel();
    emit(ProfileGetOrdersLoading());
   _orderSubscription =  _orderRepo.getOrder(getUser().uId).listen((data){
     data.fold(
           (failure) => emit(ProfileGetOrdersError(errMessage: failure.errMessage)),
           (data) {
         emit(ProfileGetOrdersSuccess(data));
       },
     );
   });
  }

  Future<void> deleteAccount(String password) async {
    emit(ProfileDeleteAccountLoading());
    final result = await _authRepo.deleteAccount(password);
    result.fold(
      (failure) => emit(ProfileDeleteAccountError(errMessage: failure.errMessage)),
      (data) {
        emit(ProfileDeleteAccountSuccess());
      },
    );
  }
  void resetState() {
    emit(ProfileInitial());
  }

  void clearError() {
    if (state is ProfileDeleteAccountError) {
      emit(ProfileInitial());
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}

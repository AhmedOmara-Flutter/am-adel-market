import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'selected_coupon_state.dart';

class SelectedCouponCubit extends Cubit<SelectedCouponState> {
  SelectedCouponCubit() : super(SelectedCouponInitial());

  void selectCoupon(String code) {
    emit(SelectedCouponSelected(code));
  }

  void clearCoupon() {
    emit(SelectedCouponInitial());
  }

}


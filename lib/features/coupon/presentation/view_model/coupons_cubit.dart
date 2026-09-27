import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/coupon_entity.dart';
import '../../data/repos/coupon_repo.dart';

part 'coupons_state.dart';

class CouponsCubit extends Cubit<CouponsState> {
  final CouponRepo couponRepo;

  CouponsCubit(this.couponRepo) : super(CouponsInitial());

  StreamSubscription? _subscription;

  void getCoupons(String userId) {
    emit(CouponsLoading());

    _subscription?.cancel();

    _subscription = couponRepo
        .getUserCoupons(
      userId: userId,
    )
        .listen(
          (result) {
        result.fold(
              (failure) {
            emit(
              CouponsFailure(
                failure.errMessage,
              ),
            );
          },
              (coupons) {
            emit(
              CouponsSuccess(coupons),
            );
          },
        );
      },
      onError: (error) {
        emit(
          CouponsFailure(
            error.toString(),
          ),
        );
      },
    );
  }

  void clear() {
    _subscription?.cancel();
    _subscription = null;

    emit(CouponsInitial());
  }
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
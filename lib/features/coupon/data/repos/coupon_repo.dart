import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/coupon_entity.dart';

abstract class CouponRepo {
  Stream<Either<Failure, List<CouponEntity>>> getUserCoupons({
    required String userId,
  });

  Future<Either<Failure, CouponEntity>> verifyCoupon({
    required String userId,
    required String code,
    required double orderTotal,
  });

  Future<Either<Failure, void>> markCouponAsUsed({
    required String userId,
    required String couponId,
  });
}

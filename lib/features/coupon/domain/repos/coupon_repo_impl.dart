import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/services/database_services.dart';
import '../../data/models/coupon_model.dart';
import '../../data/repos/coupon_repo.dart';
import '../../domain/entities/coupon_entity.dart';

class CouponRepoImpl implements CouponRepo {
  final DatabaseServices databaseServices;

  CouponRepoImpl(this.databaseServices);

  @override
  Stream<Either<Failure, List<CouponEntity>>> getUserCoupons({
    required String userId,
  }) async* {
    try {
      await for (final data in databaseServices.getStreamData(
        path: 'users',
        uId: userId,
      )) {
        if (data == null) {
          yield const Right([]);
          continue;
        }

        final userData = Map<String, dynamic>.from(data);

        final List couponsData = userData['coupons'] as List? ?? [];

        final coupons = couponsData
            .map(
              (coupon) =>
                  CouponModel.fromJson(Map<String, dynamic>.from(coupon)),
            )
            .toList();

        coupons.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        yield Right(coupons);
      }
    } catch (e) {
      yield Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CouponEntity>> verifyCoupon({
    required String userId,
    required String code,
    required double orderTotal,
  }) async {
    try {
      final data = await databaseServices.getData(path: 'users', uId: userId);

      if (data == null) {
        return Left(Failure(errMessage: 'لم يتم العثور على بيانات المستخدم'));
      }

      final userData = Map<String, dynamic>.from(data);

      final List couponsData = userData['coupons'] as List? ?? [];

      final normalizedCode = code.trim().toLowerCase();

      Map<String, dynamic>? couponData;

      for (final item in couponsData) {
        final currentCoupon = Map<String, dynamic>.from(item);

        final currentCode = currentCoupon['code']
            ?.toString()
            .trim()
            .toLowerCase();

        if (currentCode == normalizedCode) {
          couponData = currentCoupon;
          break;
        }
      }

      if (couponData == null) {
        return Left(Failure(errMessage: 'كود الكوبون غير صحيح'));
      }

      final coupon = CouponModel.fromJson(couponData);

      if (coupon.used) {
        return Left(Failure(errMessage: 'تم استخدام هذا الكوبون من قبل'));
      }

      if (!DateTime.now().isBefore(coupon.expiresAt)) {
        return Left(Failure(errMessage: 'انتهت صلاحية هذا الكوبون'));
      }

      if (orderTotal < coupon.minimumOrder) {
        return Left(
          Failure(
            errMessage:
                'الحد الأدنى لاستخدام الكوبون هو ${coupon.minimumOrder.toStringAsFixed(0)} جنيه',
          ),
        );
      }

      return Right(coupon);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> markCouponAsUsed({
    required String userId,
    required String couponId,
  }) async {
    try {
      final data = await databaseServices.getData(path: 'users', uId: userId);

      if (data == null) {
        return Left(Failure(errMessage: 'لم يتم العثور على بيانات المستخدم'));
      }

      final userData = Map<String, dynamic>.from(data);

      final List couponsData = List.from(userData['coupons'] as List? ?? []);

      final index = couponsData.indexWhere((item) {
        final coupon = Map<String, dynamic>.from(item);

        return coupon['id']?.toString() == couponId;
      });

      if (index == -1) {
        return Left(Failure(errMessage: 'لم يتم العثور على الكوبون'));
      }

      final coupon = Map<String, dynamic>.from(couponsData[index]);

      coupon['used'] = true;

      couponsData[index] = coupon;

      await databaseServices.updateData(
        path: 'users',
        docId: userId,
        data: {'coupons': couponsData},
      );

      return const Right(null);
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}

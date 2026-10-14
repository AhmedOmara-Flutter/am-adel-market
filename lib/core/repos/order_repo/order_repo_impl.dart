import 'package:dartz/dartz.dart';
import 'package:am_adel_market/core/errors/failure.dart';
import 'package:am_adel_market/core/services/database_services.dart';
import 'package:am_adel_market/core/entities/order_entity.dart';

import '../../helper_function/get_user.dart';
import '../../models/order_model.dart';
import '../../utils/app_imports.dart';
import 'order_repo.dart';

class OrderRepoImpl implements OrderRepo {
  final DatabaseServices _databaseServices;

  OrderRepoImpl(this._databaseServices);

  @override
  Future<Either<Failure, String>> addOrder(
      OrderEntity orderEntity,
      ) async {
    try {
      orderEntity.id ??= _databaseServices.generateId(
        path: 'orders',
      );

      final orderId = orderEntity.id!;
      final userId = orderEntity.uId;

      final docId = await _databaseServices.runTransaction<String>(
            (transaction) async {
          final existingOrder = await transaction.get(
            path: 'orders',
            docId: orderId,
          );

          if (existingOrder != null) {
            return orderId;
          }

          final stats = await transaction.get(
            path: 'customer_stats',
            docId: userId,
          );

          final currentCount =
              (stats?['totalOrders'] as num?)?.toInt() ?? 0;

          transaction.set(
            path: 'orders',
            docId: orderId,
            data: OrderModel.fromEntity(orderEntity).toJson(),
          );

          transaction.set(
            path: 'customer_stats',
            docId: userId,
            data: {
              'uId': userId,
              'totalOrders': currentCount + 1,
              'updatedAt': DateTime.now().toUtc().toIso8601String(),
            },
            merge: true,
          );

          return orderId;
        },
      );

      return Right(docId);
    } catch (e) {
      debugPrint('Error adding order: $e');

      return Left(
        ServerFailure(errMessage: e.toString()),
      );
    }
  }

  @override
  Stream<Either<Failure, List<OrderEntity>>> getOrder(String uId) async* {
    try {
      await for (var (data as List<Map<String, dynamic>>) in _databaseServices
          .getStreamData(
          path: 'orders',
          query: {
            'orderBy': 'createdAt',
            'descending': true,
            'where': 'uId',
            'isEqualTo': getUser().uId,
          }
      )) {
        List<OrderEntity> orders = data.map((order) =>
            OrderModel.fromJson(order).toEntity()).toList();

        yield Right(orders);
      }
    } catch (e) {
      print('error in getOrder method in profile repos impl : $e');
      yield Left(ServerFailure(errMessage: e.toString()));
    }
  }

}

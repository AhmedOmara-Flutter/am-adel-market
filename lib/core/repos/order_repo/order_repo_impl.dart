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
  Future<Either<Failure, String>> addOrder(OrderEntity orderEntity) async {
    try {
      orderEntity.id ??= _databaseServices.generateId(
        path: 'orders',
      );
      debugPrint('🔥 ORDER ID: ${orderEntity.id}');
      final docId = await _databaseServices.createDataIfNotExists(
        path: 'orders',
        docId: orderEntity.id!,
        data: OrderModel.fromEntity(orderEntity).toJson(),
      );

      return Right(docId);
    } catch (e) {
      print('error in addOrder method in profile repos impl : $e');

      return Left(
        ServerFailure(
          errMessage: e.toString(),
        ),
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

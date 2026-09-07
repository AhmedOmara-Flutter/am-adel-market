import 'package:am_adel_market/core/repos/cart_repo/cart_repo.dart';
import 'package:am_adel_market/core/services/database_services.dart';
import 'package:am_adel_market/features/cart/data/model/cart_model.dart';
import 'package:am_adel_market/features/cart/domain/entities/cart_entity.dart';

class CartRepoImpl extends CartRepo {
  final DatabaseServices databaseServices;

  CartRepoImpl(this.databaseServices);

  static const String _collection = 'carts';

  @override
  Future<CartEntity> getCart(String userId) async {
    final exists = await databaseServices.checkExists(
      path: _collection,
      uId: userId,
    );

    if (!exists) {
      return const CartEntity(cartItems: []);
    }

    final data = await databaseServices.getData(
      path: _collection,
      uId: userId,
    );

    return CartModel.fromJson(data).toEntity();
  }

  @override
  Future<void> saveCart({
    required String userId,
    required CartEntity cart,
  }) async {
    final model = CartModel.fromEntity(cart);

    final exists = await databaseServices.checkExists(
      path: _collection,
      uId: userId,
    );
    if (exists) {
      await databaseServices.updateData(
        path: _collection,
        docId: userId,
        data: model.toJson(),
      );
    } else {
      await databaseServices.addData(
        path: _collection,
        uId: userId,
        data: model.toJson(),
      );
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    final exists = await databaseServices.checkExists(
      path: _collection,
      uId: userId,
    );

    if (exists) {
      await databaseServices.deleteData(
        path: _collection,
        uId: userId,
      );
    }
  }

  Stream<CartEntity> cartStream(String userId) {
    return databaseServices.getStreamData(
      path: _collection,
      uId: userId,
    ).map((data) {
      if (data == null) {
        return const CartEntity(cartItems: []);
      }

      return CartModel.fromJson(
        Map<String, dynamic>.from(data),
      ).toEntity();
    });
  }
}
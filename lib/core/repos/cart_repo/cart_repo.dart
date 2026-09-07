import '../../../features/cart/domain/entities/cart_entity.dart';

abstract class CartRepo {
  Future<CartEntity> getCart(String userId);

  Future<void> saveCart({
    required String userId,
    required CartEntity cart,
  });

  Future<void> clearCart(String userId);

  Stream<CartEntity> cartStream(String userId);
}
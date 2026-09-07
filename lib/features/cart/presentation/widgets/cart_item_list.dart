import 'package:am_adel_market/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/utils/app_imports.dart';
import 'cart_item.dart';

class CartItemList extends StatelessWidget {
  final List<CartItemEntity> cartItem;

  const CartItemList({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: cartItem.length,
      itemBuilder: (context, index) {
        return  CartItem(cartItemEntity:cartItem[index],);
      },
    );
  }
}
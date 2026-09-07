import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:am_adel_market/features/cart/presentation/widgets/cart_info_banner.dart';
import 'package:am_adel_market/features/cart/presentation/widgets/empty_cart_widget.dart';
import '../../../../core/helper_function/price_helper.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../offers/presentation/view_model/offer_cubit.dart';
import '../view_model/cart_cubit.dart';
import 'cart_checkout_section.dart';
import 'cart_item_list.dart';

class CartViewBody extends StatelessWidget {

  const CartViewBody({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        final offerCubit = context.watch<OfferCubit>();
        final totalPrice = getCartTotalPrice(cubit, offerCubit);
        return ConditionalBuilder(
          condition: cubit.cart.cartItems.isNotEmpty, builder: (context) =>
            CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  InfoActionRow(text: 'السله'),
                  CartInfoBanner(productsInCart: cubit.cart.cartItems.length,),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            CartItemList(cartItem:cubit.cart.cartItems,),
            CartCheckoutSection(
              totalPrice: totalPrice,
            ),
          ],
            ), fallback: (context) => EmptyCartWidget(),);
      },
    );
  }
}

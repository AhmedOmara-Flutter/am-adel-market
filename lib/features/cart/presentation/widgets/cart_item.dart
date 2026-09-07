import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/cart/domain/entities/cart_item_entity.dart';
import 'package:am_adel_market/features/cart/presentation/widgets/cart_item_image.dart';
import 'package:am_adel_market/features/cart/presentation/widgets/quality_control.dart';
import '../../domain/entities/bundle_offer_cart_item_entity.dart';
import '../view_model/cart_cubit.dart';

class CartItem extends StatelessWidget {
  final CartItemEntity cartItemEntity;

  const CartItem({
    super.key,
    required this.cartItemEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 8.h,
      ),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.border,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cartItemEntity is BundleOfferCartItemEntity
              ? CartItemImage(
            image: cartItemEntity.product.image!,
          )
              : GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.productDetails,
                arguments: cartItemEntity.product.id,
              );
            },
            child: CartItemImage(
              image: cartItemEntity.product.image!,
            ),
          ),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Text(
                        cartItemEntity.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    SizedBox(width: 10.w),

                    Container(
                      width: 42.w,
                      height: 42.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF252525),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: AppColor.border.withOpacity(.5),
                          width: 1.w,
                        ),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 20.r,
                        onPressed: () {
                          context.read<CartCubit>().deleteCartItem(
                            cartItemEntity,
                            getUser().uId,
                          );
                        },
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: const Color(0xFFE53935),
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 25.h),


                Row(
                  children: [
                    QualityControl(
                      cartItemEntity: cartItemEntity,
                    ),

                    SizedBox(width: 12.w),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "الإجمالي",
                            style: StyleManager.font12Weight500.copyWith(
                              color: AppColor.textSecondary,
                            ),
                          ),

                          SizedBox(height: 4.h),

                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${(cartItemEntity.unitPrice * cartItemEntity.quantity).toStringAsFixed(2)} ج.م',
                              style: StyleManager.font18Weight700.copyWith(
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )              ],
            ),
          ),
        ],
      ),
    );
  }
}
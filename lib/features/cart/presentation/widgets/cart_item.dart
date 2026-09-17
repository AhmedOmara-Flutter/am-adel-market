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
        horizontal: 16.w,
        vertical: 7.h,
      ),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.30),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.07),
            blurRadius: 18.r,
            offset: Offset(0, 7.h),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 92.w,
            height: 112.h,
            padding: EdgeInsets.all(5.w),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: AppColor.border.withOpacity(.25),
                width: 1.w,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: cartItemEntity is BundleOfferCartItemEntity
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
            ),
          ),

          SizedBox(width: 12.w),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        cartItemEntity.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font15Weight700.copyWith(
                          color: AppColor.textPrimary,
                          height: 1.3,
                        ),
                      ),
                    ),

                    SizedBox(width: 6.w),

                    // Delete
                    Material(
                      color: AppColor.transparent,
                      child: InkWell(
                        onTap: () {
                          context.read<CartCubit>().deleteCartItem(
                            cartItemEntity,
                            getUser().uId,
                          );
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        splashColor: AppColor.red.withOpacity(.10),
                        highlightColor: AppColor.red.withOpacity(.05),
                        child: Container(
                          width: 34.w,
                          height: 34.w,
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(.07),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            color: AppColor.red,
                            size: 19.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Unit Price
                Text(
                  '${cartItemEntity.unitPrice.toStringAsFixed(2)} ج.م',
                  style: StyleManager.font13Weight600.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),

                SizedBox(height: 16.h),

                // Bottom Section
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Quantity
                    QualityControl(
                      cartItemEntity: cartItemEntity,
                    ),

                    SizedBox(width: 10.w),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.accentColor.withOpacity(.10),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColor.accentColor.withOpacity(.20),
                            width: 1.w,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'الإجمالي',
                              style: StyleManager.font12Weight500.copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${(cartItemEntity.unitPrice * cartItemEntity.quantity).toStringAsFixed(2)} ج.م',
                                style: StyleManager.font15Weight700.copyWith(
                                  color: AppColor.mainColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_imports.dart';

class CartInfoBanner extends StatelessWidget {
  final int productsInCart;

  const CartInfoBanner({
    super.key,
    required this.productsInCart,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasItems = productsInCart > 0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.28),
          width: 1.w,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // Accent Line
            Container(
              width: 4.w,
              color: hasItems
                  ? AppColor.accentColor
                  : AppColor.border.withOpacity(.55),
            ),

            SizedBox(width: 12.w),

            // Icon
            Icon(
              hasItems
                  ? Icons.shopping_bag_rounded
                  : Icons.shopping_cart_outlined,
              size: 22.sp,
              color: hasItems
                  ? AppColor.mainColor
                  : AppColor.textSecondary,
            ),

            SizedBox(width: 10.w),

            // Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      hasItems
                          ? 'سلة التسوق'
                          : 'السلة فارغة',
                      style: StyleManager.font13Weight700.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      hasItems
                          ? 'لديك $productsInCart منتجات جاهزة للطلب'
                          : 'لم تقم بإضافة أي منتجات بعد',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (hasItems) ...[
              SizedBox(width: 8.w),
              // Quantity
              Container(
                margin: EdgeInsets.only(right: 10.w,left: 10.w),
                padding: EdgeInsets.symmetric(
                  horizontal: 11.w,
                  vertical: 7.h,
                ),
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$productsInCart',
                      style: StyleManager.font13Weight700.copyWith(
                        color: AppColor.textOnDark,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'منتج',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.goldLight,
                      ),
                    ),
                  ],
                ),
              ),
            ] else
              Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 14.sp,
                  color: AppColor.border,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
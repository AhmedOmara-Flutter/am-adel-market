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
      margin: EdgeInsets.symmetric(horizontal: 16.w, ),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: hasItems
            ? AppColor.mainColor.withOpacity(0.10)
            : AppColor.card.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: hasItems
              ? AppColor.mainColor.withOpacity(0.3)
              : AppColor.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: hasItems
                  ? AppColor.mainColor.withOpacity(0.15)
                  : AppColor.border.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 18.sp,
              color: hasItems ? AppColor.mainColor : AppColor.textSecondary,
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Text(
              hasItems
                  ? 'لديك $productsInCart منتجات في سلة التسوق'
                  : 'سلة التسوق فارغة حالياً',
              style: hasItems
                  ? StyleManager.font14Weight600
                  : StyleManager.font13Weight600,
            ),
          ),

          if (hasItems)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 4.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                '$productsInCart',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
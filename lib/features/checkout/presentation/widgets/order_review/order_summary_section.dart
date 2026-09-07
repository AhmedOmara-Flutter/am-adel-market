import 'package:cached_network_image/cached_network_image.dart';
import 'package:am_adel_market/core/entities/order_entity.dart';

import '../../../../../core/utils/app_imports.dart';

class OrderSummarySection extends StatelessWidget {
  final double totalPrice;
  final double delivery;
  final OrderEntity order;

  const OrderSummarySection({
    super.key,
    required this.totalPrice,
    required this.delivery,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...order.cartEntity.cartItems.map(
                (item) => Container(
              margin: EdgeInsets.only(bottom: 7.h),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.background,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.border,
                  width: 0.7,
                ),
              ),
              child: Row(
                children: [
                  // Product Name
                  Expanded(
                    child: Text(
                      item.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font12Weight500.copyWith(
                        color: AppColor.white,
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Price
                  Text(
                    '${item.unitPrice.toStringAsFixed(2)} ج.م',
                    style: StyleManager.font11Weight400.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),

                  SizedBox(width: 10.w),

                  // Quantity
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 7.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.mainColor.withOpacity(.12),
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                    child: Text(
                      '×${item.quantity}',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المجموع الفرعي :',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'التوصيل :',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '$totalPrice جنيه',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '$delivery جنيه',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 8.h,
              bottom: 12.h,
              left: 20.w,
              right: 20.w,
            ),
            child: Divider(color: AppColor.border),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'الكلي',
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(color: AppColor.textPrimary),
              ),
              Text(
                '${(totalPrice + delivery).toStringAsFixed(2)} جنيه',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

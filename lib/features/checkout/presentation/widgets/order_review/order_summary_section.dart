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
    final grandTotal = totalPrice + delivery;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.border.withOpacity(.22)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(.055),
            blurRadius: 24.r,
            offset: Offset(0, 10.h),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Column(
          children: [
            // ─────────────────────────────────────────────
            // Header
            // ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 14.h),
              child: Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: AppColor.textOnDark,
                      size: 21.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ملخص الطلب',
                          style: StyleManager.font16Weight700.copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          '${order.cartEntity.cartItems.length} منتجات',
                          style: StyleManager.font11Weight400.copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Divider(
                height: 1,
                color: AppColor.divider.withOpacity(.45),
              ),
            ),

            // ─────────────────────────────────────────────
            // Products
            // ─────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 4.h),
              child: Column(
                children: [
                  ...order.cartEntity.cartItems.map(
                    (item) => Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 42.w,
                            height: 42.w,
                            decoration: BoxDecoration(
                              color: AppColor.background,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.restaurant_rounded,
                              color: AppColor.secondaryColor,
                              size: 19.sp,
                            ),
                          ),

                          SizedBox(width: 10.w),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: StyleManager.font13Weight700.copyWith(
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 3.h),
                                Text(
                                  '${item.unitPrice.toStringAsFixed(2)} ج.م × ${item.quantity}',
                                  style: StyleManager.font11Weight400.copyWith(
                                    color: AppColor.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 8.w),

                          Text(
                            '${item.totalPrice.toStringAsFixed(2)} ج.م',
                            style: StyleManager.font13Weight700.copyWith(
                              color: AppColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─────────────────────────────────────────────
            // Price Breakdown
            // ─────────────────────────────────────────────
            Container(
              margin: EdgeInsets.only(
                top: 6.h,
                left: 12.w,
                right: 12.w,
                bottom: 12.h,
              ),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.background.withOpacity(.55),
                borderRadius: BorderRadius.circular(17.r),
                border: Border.all(color: AppColor.border.withOpacity(.15)),
              ),
              child: Column(
                children: [
                  _PriceRow(
                    title: 'المجموع الفرعي',
                    value: '${totalPrice.toStringAsFixed(2)} ج.م',
                  ),

                  SizedBox(height: 11.h),

                  _PriceRow(
                    title: 'رسوم التوصيل',
                    value: '${delivery.toStringAsFixed(2)} ج.م',
                    valueColor: AppColor.secondaryColor,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 13.h),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: AppColor.divider.withOpacity(.55),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Icon(
                            Icons.more_horiz_rounded,
                            color: AppColor.border,
                            size: 16.sp,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColor.divider.withOpacity(.55),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Total
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الإجمالي',
                              style: StyleManager.font15Weight700.copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'شامل رسوم التوصيل',
                              style: StyleManager.font11Weight400.copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Text(
                        '${grandTotal.toStringAsFixed(2)}',
                        style: StyleManager.font23Weight700.copyWith(
                          color: AppColor.mainColor,
                        ),
                      ),

                      SizedBox(width: 4.w),

                      Text(
                        'ج.م',
                        style: StyleManager.font12Weight500.copyWith(
                          color: AppColor.accentColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _PriceRow({required this.title, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: StyleManager.font12Weight500.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
        Text(
          value,
          style: StyleManager.font13Weight700.copyWith(
            color: valueColor ?? AppColor.textPrimary,
          ),
        ),
      ],
    );
  }
}

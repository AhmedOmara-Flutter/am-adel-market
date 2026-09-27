import 'package:am_adel_market/core/entities/order_entity.dart';

import '../../../../../core/utils/app_imports.dart';

class OrderSummarySection extends StatelessWidget {
  final double totalPrice;
  final double delivery;
  final double discount;
  final OrderEntity order;

  const OrderSummarySection({
    super.key,
    required this.totalPrice,
    required this.delivery,
    this.discount = 0,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final grandTotal = totalPrice + delivery;
    final finalTotal = (grandTotal - discount).clamp(0, double.infinity);

    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.18),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            splashColor: AppColor.mainColor.withOpacity(.04),
            highlightColor: AppColor.mainColor.withOpacity(.02),
          ),
          child: ExpansionTile(
            tilePadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 4.h,
            ),
            childrenPadding: EdgeInsets.zero,
            initiallyExpanded: false,
            shape: const RoundedRectangleBorder(),
            collapsedShape: const RoundedRectangleBorder(),
            leading: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(.08),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.receipt_long_rounded,
                color: AppColor.mainColor,
                size: 20.sp,
              ),
            ),
            title: Text(
              'ملخص الطلب',
              style: StyleManager.font15Weight700.copyWith(
                color: AppColor.textPrimary,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Text(
                '${order.cartEntity.cartItems.length} منتجات',
                style: StyleManager.font11Weight400.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${finalTotal.toStringAsFixed(2)} ج.م',
                  style: StyleManager.font14Weight600.copyWith(
                    color: AppColor.mainColor,
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColor.textSecondary,
                  size: 22.sp,
                ),
              ],
            ),
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  16.w,
                  2.h,
                  16.w,
                  14.h,
                ),
                child: Column(
                  children: [
                    Divider(
                      height: 1,
                      color: AppColor.divider.withOpacity(.35),
                    ),

                    SizedBox(height: 14.h),

                    ...order.cartEntity.cartItems.map(
                          (item) =>
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.background,
                                    borderRadius: BorderRadius.circular(11.r),
                                  ),
                                  child: Icon(
                                    Icons.restaurant_rounded,
                                    color: AppColor.secondaryColor,
                                    size: 18.sp,
                                  ),
                                ),

                                SizedBox(width: 10.w),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                        StyleManager.font13Weight700.copyWith(
                                          color: AppColor.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 3.h),
                                      Text(
                                        '${item.unitPrice.toStringAsFixed(
                                            2)} ج.م × ${item.quantity}',
                                        style:
                                        StyleManager.font11Weight400.copyWith(
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
                                    color: AppColor.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    ),

                    SizedBox(height: 4.h),

                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: AppColor.background.withOpacity(.45),
                        borderRadius: BorderRadius.circular(15.r),
                        border: Border.all(
                          color: AppColor.border.withOpacity(.12),
                        ),
                      ),
                      child: Column(
                        children: [
                          _PriceRow(
                            title: 'المجموع الفرعي',
                            value:
                            '${totalPrice.toStringAsFixed(2)} ج.م',
                          ),

                          SizedBox(height: 10.h),

                          _PriceRow(
                            title: 'رسوم التوصيل',
                            value:
                            '${delivery.toStringAsFixed(2)} ج.م',
                            valueColor: AppColor.secondaryColor,
                          ),

                          if (discount > 0) ...[
                            SizedBox(height: 10.h),

                            _PriceRow(
                              title: 'الخصم',
                              value:
                              '-${discount.toStringAsFixed(2)} ج.م',
                              valueColor: AppColor.mainColor,
                            ),
                          ],

                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Divider(
                              height: 1,
                              color: AppColor.divider.withOpacity(.4),
                            ),
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'الإجمالي',
                                      style:
                                      StyleManager.font15Weight700.copyWith(
                                        color: AppColor.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      discount > 0
                                          ? 'بعد تطبيق الخصم'
                                          : 'شامل رسوم التوصيل',
                                      style:
                                      StyleManager.font11Weight400.copyWith(
                                        color: AppColor.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                finalTotal.toStringAsFixed(2),
                                style: StyleManager.font23Weight700.copyWith(
                                  color: AppColor.mainColor,
                                ),
                              ),

                              SizedBox(width: 4.w),

                              Text(
                                'ج.م',
                                style:
                                StyleManager.font12Weight500.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _PriceRow({
    required this.title,
    required this.value,
    this.valueColor,
  });

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

import '../../../../core/utils/app_imports.dart';

class OrderItemContent extends StatelessWidget {
  final String orderId;
  final String orderDate;
  final String products;
  final int numberOfOrders;
  final String ordersTotalPrice;
  final String price;
  final double deliveryCost;
  final double couponDiscount;

  const OrderItemContent({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.numberOfOrders,
    required this.ordersTotalPrice,
    required this.products,
    required this.price,
    required this.deliveryCost,
    required this.couponDiscount,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = AppColor.mainColor;
    final total = double.parse(ordersTotalPrice);
    final hasCoupon = couponDiscount > 0;

    return Padding(
      padding: EdgeInsets.only(
        top: 10.h,
        bottom: 10.h,
        right: 8.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'طلب رقم : ',
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: Text(
                  '#$orderId',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(
                    color: AppColor.textPrimary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          Text(
            'تم الطلب : $orderDate',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme
                .of(context)
                .textTheme
                .titleSmall!
                .copyWith(
              color: AppColor.textSecondary,
            ),
          ),

          SizedBox(height: 8.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  products,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ),

              SizedBox(width: 10.w),

              Flexible(
                child: Text(
                  price,
                  maxLines: 2,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: Theme
                      .of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColor.border,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: 18,
                  color: primaryColor,
                ),

                SizedBox(width: 6.w),

                Flexible(
                  child: Text(
                    '$numberOfOrders منتجات',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),

                SizedBox(width: 8.w),

                Tooltip(
                  triggerMode: TooltipTriggerMode.tap,
                  message:
                  'الإجمالي النهائي: ${total.toStringAsFixed(2)} ج.م\n'
                      'التوصيل: ${deliveryCost.toStringAsFixed(2)} ج.م'
                      '${hasCoupon ? '\nخصم الكوبون: ${couponDiscount.toStringAsFixed(2)} ج.م' : ''}',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: AppColor.textSecondary,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${total.toStringAsFixed(2)} ج.م',
                        maxLines: 1,
                        style: Theme
                            .of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

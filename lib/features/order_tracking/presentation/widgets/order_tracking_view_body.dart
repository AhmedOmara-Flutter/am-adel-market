import 'package:am_adel_market/core/entities/order_entity.dart';
import 'package:am_adel_market/core/helper_function/get_date_formate.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

import '../../../profile/presentation/widgets/order_item_image.dart';
import 'order_time_line.dart';

class OrderTrackingViewBody extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderTrackingViewBody({
    super.key,
    required this.orderEntity,
  });

  @override
  Widget build(BuildContext context) {
    final total = orderEntity.cartEntity.getTotalPrice() +
        orderEntity.selectedLocationEntity!.cost;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          children: [
            const InfoActionRow(
              text: 'تتبع الطلب',
              showBack: true,
              topPadding: 10.0,

            ),

            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.h,
                horizontal: 15.w,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              decoration: BoxDecoration(
                color: AppColor.cardLight,
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: AppColor.border.withOpacity(.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(.06),
                    blurRadius: 12.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OrderItemImage(),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10.h,
                        horizontal: 8.w,
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
                                  color: AppColor.mainColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  '#${orderEntity.id}',
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                    color: AppColor.textPrimary,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 4.h),

                          Text(
                            'تم الطلب : ${getDateFormate(
                                orderEntity.createdAt.toString())}',
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

                          SizedBox(height: 10.h),

                          RichText(
                            text: TextSpan(
                              text: 'عدد المنتجات : ',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                color: AppColor.textSecondary,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                  '${orderEntity.cartEntity.getItemsCount()}',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                    color: AppColor.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const TextSpan(text: '    '),
                                TextSpan(
                                  text:
                                  '${total.toStringAsFixed(2)} ج.م',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                    color: AppColor.accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            OrderTimeline(
              status: orderEntity.status,
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
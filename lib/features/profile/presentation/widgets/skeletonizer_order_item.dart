import '../../../../core/utils/app_imports.dart';
import 'order_item_content.dart';
import 'order_item_image.dart';

class SkeletonizerOrderItem extends StatelessWidget {
  const SkeletonizerOrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColor.card,
        highlightColor: AppColor.border,
        duration: const Duration(milliseconds: 1200),
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: 10.h,
          bottom: 10.h,
          left: 15.w,
        ),
        margin: EdgeInsets.only(
          bottom: 15.h,
          left: 20.w,
          right: 20.w,
        ),
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Row(
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.mainColor.withOpacity(.12),
                    ),
                    child: SvgPicture.asset(
                      Assets.assets.images.package.path,
                      width: 30.w,
                      height: 30.w,
                      colorFilter: const ColorFilter.mode(
                        AppColor.mainColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  Expanded(
                    child: OrderItemContent(
                      orderId: 'omrnrijnbinrnmn',
                      orderDate: 'mioni nin iniuiiniooi',
                      numberOfOrders: 555,
                      ordersTotalPrice: '78888',
                      products: 'jniniunin jinin',
                      price: 'rgji rnr',
                      deliveryCost: 78888,
                    ),
                  ),
                ],
              ),
            ),

            OrderStatusBadge(
              color: AppColor.border,
              title: 'rd]hghhkjjhv',
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({
    super.key,
    required this.title,
    required this.color,
  });

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7.w),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall!.copyWith(
          color: color.withOpacity(.9),
        ),
      ),
    );
  }
}
import 'package:am_adel_market/features/profile/presentation/widgets/rate_order_button.dart';
import 'package:am_adel_market/features/order_review/data/repos/order_review_repo.dart';
import '../../../../core/entities/order_entity.dart';
import '../../../../core/enums/order_enum.dart';
import '../../../../core/helper_function/get_date_formate.dart';
import '../../../../core/utils/app_imports.dart';
import 'order_item_content.dart';
import 'order_item_image.dart';
import 'order_status_badge.dart';

class OrderItem extends StatefulWidget {
  final OrderEntity orderEntity;

  const OrderItem({super.key, required this.orderEntity});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  late Future<bool> _reviewStatusFuture;

  @override
  void initState() {
    super.initState();
    _loadReviewStatus();
  }

  void _loadReviewStatus() {
    final orderId = widget.orderEntity.id ?? '';

    if (orderId.trim().isEmpty) {
      _reviewStatusFuture = Future.value(false);
      return;
    }

    _reviewStatusFuture = _checkReviewStatus(orderId);
  }

  Future<bool> _checkReviewStatus(String orderId) async {
    try {
      final result = await instance<OrderReviewRepo>().hasReviewed(orderId);

      return result.fold((failure) => false, (hasReviewed) => hasReviewed);
    } catch (_) {
      return false;
    }
  }

  @override
  void didUpdateWidget(covariant OrderItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.orderEntity.id != widget.orderEntity.id) {
      _loadReviewStatus();
    }
  }

  Future<void> _openReviewPage() async {
    await Navigator.pushNamed(
      context,
      RouteManager.orderReview,
      arguments: widget.orderEntity,
    );

    if (!mounted) return;

    setState(_loadReviewStatus);
  }

  @override
  Widget build(BuildContext context) {
    final orderEntity = widget.orderEntity;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteManager.orderTracking,
          arguments: orderEntity,
        );
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 15.w),
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColor.border.withOpacity(.22)),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(.035),
              blurRadius: 14.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      const OrderItemImage(),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OrderItemContent(
                          orderId: orderEntity.id ?? '',
                          orderDate: getDateFormate(
                            orderEntity.createdAt.toString(),
                          ),
                          numberOfOrders: orderEntity.cartEntity
                              .getItemsCount(),
                          ordersTotalPrice: orderEntity.totalPrice
                              .toStringAsFixed(2),
                          products: orderEntity.cartEntity.cartItems
                              .map(
                                (item) =>
                                    '${item.product.name} × ${item.quantity}',
                              )
                              .join('\n'),
                          price: orderEntity.cartEntity.cartItems
                              .map((item) => '${item.unitPrice} ج.م')
                              .join('\n'),
                          deliveryCost:
                              orderEntity.selectedLocationEntity!.cost,
                          couponDiscount: orderEntity.couponDiscount,
                        ),
                      ),
                    ],
                  ),
                  if (orderEntity.status == OrderStatus.delivered)
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FutureBuilder<bool>(
                          future: _reviewStatusFuture,
                          builder: (context, snapshot) {
                            final isRated = snapshot.data ?? false;

                            return RateOrderButton(
                              isRated: isRated,
                              onTap:
                                  snapshot.connectionState ==
                                          ConnectionState.waiting ||
                                      isRated
                                  ? null
                                  : _openReviewPage,
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            OrderStatusBadge(
              color: orderEntity.status == OrderStatus.paid
                  ? OrderStatus.delivered.color
                  : orderEntity.status.color,
              title: orderEntity.status == OrderStatus.paid
                  ? 'تم الانتهاء'
                  : orderEntity.status.ar,
            ),
          ],
        ),
      ),
    );
  }
}

import '../../../../core/entities/order_entity.dart';
import '../../../../core/utils/app_imports.dart';
import '../widgets/order_tracking_view_body.dart';

class OrderTrackingView extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderTrackingView({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderTrackingViewBody(orderEntity: orderEntity),
    );
  }
}

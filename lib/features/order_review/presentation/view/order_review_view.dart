
import '../../../../core/utils/app_imports.dart';
import '../../../../core/entities/order_entity.dart';
import '../view_model/order_review_cubit.dart';
import '../widgets/order_review_view_body.dart';

class OrderReviewView extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderReviewView({
    super.key,
    required this.orderEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => instance<OrderReviewCubit>(),
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: OrderReviewViewBody(
          orderEntity: orderEntity,
        ),
      ),
    );
  }
}

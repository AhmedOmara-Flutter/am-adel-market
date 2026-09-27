import '../../../../core/entities/order_entity.dart';
import '../../../../core/repos/location_repo/selected_location_repo.dart';
import '../../../../core/repos/order_repo/order_repo.dart';
import '../../../../core/repos/upload_image_repo/upload_image_repo.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../coupon/data/repos/coupon_repo.dart';
import '../view_model/checkout_cubit.dart';
import '../widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  final OrderEntity orderEntity;

  const CheckoutView({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(
      orderEntity,
      instance<OrderRepo>(),
      instance<UploadImageRepo>(),
      instance<SelectedLocationRepo>(),
        instance<CouponRepo>(),
    ),
      child: Scaffold(
        body: CheckoutViewBody(),
      ),
    );
  }
}

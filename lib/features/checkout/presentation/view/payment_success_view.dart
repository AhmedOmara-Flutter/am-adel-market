import 'package:am_adel_market/core/helper_function/get_user.dart';

import '../../../../core/entities/order_entity.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';

class PaymentSuccessView extends StatelessWidget {
  final OrderEntity orderEntity;

  const PaymentSuccessView({
    super.key,
    required this.orderEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          InfoActionRow(text: 'الدفع'),

          SizedBox(height: 35.h),

          AspectRatio(
            aspectRatio: 3,
            child: SvgPicture.asset(
              Assets.assets.images.paymentSuccess.path,
            ),
          ),

          SizedBox(height: 30.h),

          Text(
            'تم بنجاح !',
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: AppColor.textPrimary,
            ),
          ),

          SizedBox(height: 15.h),

          Text(
            'رقم الطلب : ${orderEntity.id}#',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColor.textSecondary,
            ),
          ),

          const Spacer(),
          CustomButton(
            onPressed: () {
              context.read<CartCubit>().cart.cartItems.clear();
              context.read<CartCubit>().saveCart(getUser().uId);
              context.read<MainCubit>().currentIndex = 0;
              Navigator.pushNamed(
                context,
                RouteManager.home,
              );
            },
            child: Text(
              'الرئيسيه',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';

class PaymentMethodButtonSection extends StatelessWidget {
  const PaymentMethodButtonSection({super.key,});


  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return CustomButton(
      onPressed: () {
        if (cubit.isCashOnDelivery != null) {
          cubit.pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          cubit.orderEntity.isCashOnDelivery = cubit.isCashOnDelivery;
          print(cubit.orderEntity.isCashOnDelivery);
          print(cubit.orderEntity.cartEntity.getTotalPrice());
        } else {
          AppVibration.heavy();
          AppSounds.playClickSound('click_error.wav');
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: 'يرجي اختيار طريقه الدفع',
          );
        }
      },
      child: Text('التالي', style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

import 'package:am_adel_market/features/checkout/presentation/view_model/checkout_cubit.dart';

import '../../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../../core/utils/app_imports.dart';

class OrderReviewButtonSection extends StatelessWidget {
  const OrderReviewButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        return CustomButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();

            if (cubit.enteredCouponCode.isNotEmpty &&
                cubit.appliedCoupon == null) {
              AppVibration.heavy();
              AppSounds.playClickSound('click_error.wav');
              customShowSnakeBar(context, color: AppColor.red, label: 'يرجى التحقق من الكوبون أولاً');
              return;
            }

            CustomShowDialog.show(
              context,
              title: 'تأكيد الدفع',
              content: Text(
                'هل أنت متأكد من إتمام عملية الدفع؟',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
              accept: () async {
                Navigator.pop(context);

                cubit.orderEntity.orderNote =
                    cubit.notesController.text.trim();

                await cubit.addOrder(cubit.orderEntity);
              },
              cancel: () {
                Navigator.pop(context);
              },
            );
          },
          child: Text(
            'تاكيد الطلب',
            style:StyleManager.font15Weight800.copyWith(color: AppColor.white),
          ),
        );
      },
    );
  }
}
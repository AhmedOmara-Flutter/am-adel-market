import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/widgets/custom_loading.dart';

import '../../../../core/utils/app_imports.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../view_model/checkout_cubit.dart';
import 'checkout_stepper.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutAddOrderSuccess) {
          AppVibration.heavy();
          AppSounds.playClickSound('payment.mp3');
          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم تأكيد طلبك بنجاح',
          );
          context.read<CartCubit>().cart.cartItems.clear();
          context.read<CartCubit>().saveCart(getUser().uId);
          context.read<MainCubit>().currentIndex = 0;
          Navigator.pushReplacementNamed(
            context,
            RouteManager.paymentSuccess,
            arguments: context.read<CheckoutCubit>().orderEntity,
          );
        } else if (state is CheckoutAddOrderError) {
          AppVibration.heavy();
          AppSounds.playClickSound('click_error.wav');
          customShowSnakeBar(context, color: AppColor.red, label: state.error);
        }
      },
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        return Stack(
          children: [
            Column(
              children: [
                InfoActionRow(
                  text: 'اتمام الطلب',
                  showBack: true,
                ),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        CheckoutStepper(
                          currentIndex: cubit.currentIndex,
                          stepperTitles: cubit.stepperTitles,
                        ),
                        Expanded(
                          child: PageView.builder(
                            controller: cubit.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cubit.stepperPages.length,
                            onPageChanged: (index) {
                              cubit.changePage(index);
                            },
                            itemBuilder: (context, index) {
                              return cubit.stepperPages[index];
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (state is CheckoutAddOrderLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    child: LoadingWidget(),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';
import '../../widgets/order_review/delivery_address_section.dart';
import '../../widgets/order_review/order_notes_section.dart';
import '../../widgets/order_review/order_review_button_section.dart';
import '../../widgets/order_review/order_summary_section.dart';
import '../../widgets/order_review/payment_proof_section.dart';

class ReviewOrderView extends StatefulWidget {
  const ReviewOrderView({super.key});

  @override
  State<ReviewOrderView> createState() => _ReviewOrderViewState();
}

class _ReviewOrderViewState extends State<ReviewOrderView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        return SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ملخص الطلب :',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      OrderSummarySection(
                        totalPrice: cubit.orderEntity.cartEntity
                            .getTotalPrice()
                            .toDouble(),
                        delivery:
                        cubit.orderEntity.selectedLocationEntity!.cost,
                        order:cubit.orderEntity,
                      ),
                      SizedBox(height: 10.h),
                      DeliveryInfoSection(
                        locationName:
                        cubit.orderEntity.selectedLocationEntity!.title,
                        deliveryCost:
                        cubit.orderEntity.selectedLocationEntity!.cost,
                        fullAddress: cubit.orderEntity.getFullAddress(),
                        onEdit: () {
                          cubit.pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      if (cubit.orderEntity.isCashOnDelivery == false)
                        PaymentProofSection(),
                      OrderNotesSection(
                        controller: cubit.notesController,
                      ),
                      const Spacer(),
                      SizedBox(height: 30.h),
                      OrderReviewButtonSection(),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

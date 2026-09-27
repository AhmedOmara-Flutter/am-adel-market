  import '../../../../../core/cubit/selected_coupon_cubit/selected_coupon_cubit.dart';
import '../../../../../core/utils/app_imports.dart';
import '../../../../coupon/presentation/view_model/coupons_cubit.dart';
import '../../view_model/checkout_cubit.dart';
import '../../widgets/order_review/coupon_verification_section.dart';
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
    return BlocListener<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutCouponError) {
          customShowSnakeBar(context, color: AppColor.red, label: state.error);
        }

        if (state is CheckoutCouponSuccess) {
          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم تطبيق الكوبون بنجاح',
          );
        }
      },
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
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
                        OrderSummarySection(
                          totalPrice: cubit.orderEntity.cartEntity
                              .getTotalPrice()
                              .toDouble(),
                          delivery:
                              cubit.orderEntity.selectedLocationEntity!.cost,
                          discount: cubit.couponDiscount,
                          order: cubit.orderEntity,
                        ),

                        BlocBuilder<CouponsCubit, CouponsState>(
                          builder: (context, couponsState) {
                            if (couponsState is! CouponsSuccess ||
                                !couponsState.coupons.any(
                                  (coupon) =>
                                      !coupon.used &&
                                      DateTime.now().isBefore(coupon.expiresAt),
                                )) {
                              return const SizedBox.shrink();
                            }

                            return BlocBuilder<CheckoutCubit, CheckoutState>(
                              builder: (context, checkoutState) {
                                final checkoutCubit = context
                                    .read<CheckoutCubit>();

                                return BlocBuilder<
                                  SelectedCouponCubit,
                                  SelectedCouponState
                                >(
                                  builder: (context, couponState) {
                                    final selectedCouponCode =
                                        couponState is SelectedCouponSelected
                                        ? couponState.code
                                        : null;

                                    return CouponVerificationSection(
                                      initialCode: selectedCouponCode,
                                      isValid:
                                          checkoutCubit.appliedCoupon != null,
                                      discountText:
                                          checkoutCubit.appliedCoupon != null
                                          ? '${checkoutCubit.couponDiscount.toStringAsFixed(2)} ج.م'
                                          : null,
                                      onVerify: (code) {
                                        checkoutCubit.verifyCoupon(code);
                                      },
                                      onRemove: () {
                                        checkoutCubit.removeCoupon();
                                        context
                                            .read<SelectedCouponCubit>()
                                            .clearCoupon();
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),
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

                        if (cubit.orderEntity.isCashOnDelivery == false)
                          PaymentProofSection(),

                        OrderNotesSection(controller: cubit.notesController),

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
      ),
    );
  }
}

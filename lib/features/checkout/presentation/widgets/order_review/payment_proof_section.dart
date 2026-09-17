import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';
import '../custom_image_picker.dart';

class PaymentProofSection extends StatelessWidget {
  const PaymentProofSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColor.border.withOpacity(.22)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(.045),
            blurRadius: 22.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColor.textOnDark,
                  size: 21.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'إضافة بيانات الدفع',
                      style: StyleManager.font16Weight700.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'أرفق إثبات الدفع لإتمام طلبك',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(13.w),
                    decoration: BoxDecoration(
                      color: AppColor.background.withOpacity(.55),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColor.border.withOpacity(.16),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: AppColor.accentColor.withOpacity(.13),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.info_outline_rounded,
                                color: AppColor.accentColor,
                                size: 17.sp,
                              ),
                            ),
                            SizedBox(width: 9.w),
                            Expanded(
                              child: Text(
                                'يرجى إرفاق صورة واضحة لإثبات الدفع',
                                style: StyleManager.font12Weight500.copyWith(
                                  color: AppColor.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),

                        _PaymentMethodRow(
                          icon: Icons.camera_alt_outlined,
                          title: 'إنستا باي',
                          value: '01150279072',
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(
                            height: 1,
                            color: AppColor.divider.withOpacity(.4),
                          ),
                        ),

                        _PaymentMethodRow(
                          icon: Icons.payments_outlined,
                          title: 'كاش',
                          value: '01014214972',
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                CustomImagePicker(
                  onImagePicked: (image) {
                    context
                        .read<CheckoutCubit>()
                        .orderEntity
                        .paymentFileImage = image;
                  },
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}

class _PaymentMethodRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _PaymentMethodRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: AppColor.mainColor.withOpacity(.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColor.mainColor, size: 16.sp),
        ),
        SizedBox(width: 9.w),
        Text(
          title,
          style: StyleManager.font11Weight400.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: StyleManager.font12Weight500.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: .2,
          ),
        ),
      ],
    );
  }
}

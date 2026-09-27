import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';
import '../custom_image_picker.dart';

class PaymentProofSection extends StatelessWidget {
  const PaymentProofSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
                  color: AppColor.mainColor,
                  size: 19.sp,
                ),
              ),
              SizedBox(width: 9.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بيانات الدفع',
                      style: StyleManager.font15Weight700.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'أرفق إثبات الدفع لإتمام الطلب',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 115.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 15.h),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(13.r),
                    border: Border.all(
                      color: AppColor.border.withOpacity(.12),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _PaymentMethodRow(
                        icon: Icons.camera_alt_outlined,
                        title: 'إنستا باي',
                        value: '01150279072',
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 7.h),
                        child: Divider(
                          height: 1,
                          color: AppColor.divider.withOpacity(.35),
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

              SizedBox(width: 10.w),

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
          child: Icon(
            icon,
            color: AppColor.mainColor,
            size: 16.sp,
          ),
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
          style: StyleManager.font11Weight400.copyWith(
            color: AppColor.textPrimary,
            letterSpacing: .2,
          ),
        ),
      ],
    );
  }
}

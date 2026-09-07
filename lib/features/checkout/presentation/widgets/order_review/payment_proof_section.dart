import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';
import '../custom_image_picker.dart';

class PaymentProofSection extends StatelessWidget {
  const PaymentProofSection({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'إضافة بيانات الدفع',
                  style: Theme.of(context).textTheme.labelLarge,
                ),

                SizedBox(height: 10.h),

                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withOpacity(.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColor.mainColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColor.mainColor,
                        size: 20.sp,
                      ),

                      SizedBox(width: 8.w),

                      Expanded(
                        child: Text(
                          'يرجى إرفاق صورة واضحة لإثبات الدفع.\nانستا: 01150279072\nكاش: 01014214972',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                            color: AppColor.textSecondary,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          CustomImagePicker(
            onImagePicked: (image) {
              context.read<CheckoutCubit>().orderEntity.paymentFileImage = image;
            },
          ),
        ],
      ),
    );
  }
}
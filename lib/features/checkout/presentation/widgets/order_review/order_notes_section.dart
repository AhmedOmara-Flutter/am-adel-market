import '../../../../../core/utils/app_imports.dart';

class OrderNotesSection extends StatelessWidget {
  const OrderNotesSection({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColor.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.edit_note_rounded,
                  color: AppColor.mainColor,
                  size: 22.sp,
                ),
              ),

              SizedBox(width: 12.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ملاحظات الطلب',
                      style: StyleManager.font16Weight700,
                    ),

                    SizedBox(height: 2.h),

                    Text(
                      'أضف أي تعليمات خاصة بالطاهي (اختياري)',
                      style: StyleManager.font12Weight500.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          CustomTextFormField(
            controller: controller,
            hintText:
            'مثال: بدون سلطة، بدون بصل، زيادة جبنة، حار...',
            prefixIcon: Icons.notes_rounded,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}
import '../../../../../core/utils/app_imports.dart';

class OrderNotesSection extends StatelessWidget {
  const OrderNotesSection({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h),
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
                  Icons.edit_note_rounded,
                  color: AppColor.textOnDark,
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
                      style: StyleManager.font16Weight700.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'أضف أي تعليمات خاصة بالطاهي (اختياري)',
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

          Container(
            padding: EdgeInsets.all(13.w),
            decoration: BoxDecoration(
              color: AppColor.background.withOpacity(.55),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColor.border.withOpacity(.16)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: AppColor.accentColor.withOpacity(.13),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lightbulb_outline_rounded,
                    color: AppColor.accentColor,
                    size: 17.sp,
                  ),
                ),
                SizedBox(width: 9.w),
                Expanded(
                  child: Text(
                    'اكتب أي تفاصيل تساعدنا في تجهيز طلبك بالشكل الذي تفضله.',
                    style: StyleManager.font12Weight500.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 13.h),

          CustomTextFormField(
            controller: controller,
            hintText: 'مثال: بدون سلطة، بدون بصل، زيادة جبنة، حار...',
            prefixIcon: Icons.notes_rounded,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }
}

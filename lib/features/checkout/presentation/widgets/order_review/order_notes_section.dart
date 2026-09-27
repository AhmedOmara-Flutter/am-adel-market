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
                  Icons.edit_note_rounded,
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
                      'ملاحظات الطلب',
                      style: StyleManager.font14Weight600.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'اختياري',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 10.h),

          Container(
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColor.accentColor.withValues(alpha: 0.12),
              ),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              style: StyleManager.font14Weight600.copyWith(
                color: AppColor.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'مثال: بدون بصل، زيادة جبنة، حار...',
                hintStyle: StyleManager.font11Weight400.copyWith(
                  color: AppColor.textSecondary,
                ),
                prefixIcon: Icon(
                  Icons.notes_rounded,
                  color: AppColor.secondaryColor,
                  size: 20.sp,
                ),
                alignLabelWithHint: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 13.w,
                  vertical: 12.h,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

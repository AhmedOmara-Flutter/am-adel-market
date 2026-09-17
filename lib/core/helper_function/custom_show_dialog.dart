import '../utils/app_imports.dart';

class CustomShowDialog {
  static Future<void> show(BuildContext context, {
    required String title,
    required Widget content,
    VoidCallback? cancel,
    VoidCallback? accept,
    Color color = AppColor.mainColor,
    IconData flag = Icons.payment_rounded,
    String cancelText = 'إلغاء',
    String acceptText = 'تأكيد',
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          backgroundColor: AppColor.cardLight,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          contentPadding: EdgeInsets.all(22.w),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
// Icon
              Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.backgroundDark,
                  border: Border.all(
                    color: AppColor.border.withOpacity(.35),
                    width: 1,
                  ),
                ),
                child: Icon(
                  flag,
                  size: 36.sp,
                  color: AppColor.mainColor,
                ),
              ),

              SizedBox(height: 18.h),

// Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.h),

// Content
              content,

              SizedBox(height: 24.h),

// Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: cancel ?? () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColor.cardLight,
                        foregroundColor: AppColor.textPrimary,
                        side: BorderSide(
                          color: AppColor.border,
                          width: 1.2,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                        ),
                      ),
                      child: Text(
                        cancelText,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: accept,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.mainColor,
                        foregroundColor: AppColor.textOnDark,
                        elevation: 2,
                        shadowColor: AppColor.black.withOpacity(.18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                        ),
                      ),
                      child: Text(
                        acceptText,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: AppColor.textOnDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

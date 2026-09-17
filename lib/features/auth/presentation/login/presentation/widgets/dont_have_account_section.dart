import 'package:am_adel_market/core/utils/app_imports.dart';

class DontHaveAccountSection extends StatelessWidget {
  const DontHaveAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.border.withOpacity(0.5),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(0.06),
            blurRadius: 10.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'لا تمتلك حساب؟',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColor.textPrimary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(width: 8.w),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.register,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 5.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Text(
                'إنشاء حساب',
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColor.textOnDark,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



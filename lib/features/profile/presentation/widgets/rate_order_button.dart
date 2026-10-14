import '../../../../core/utils/app_imports.dart';

class RateOrderButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isRated;

  const RateOrderButton({super.key, required this.onTap, this.isRated = false});

  @override
  Widget build(BuildContext context) {
    final color = isRated ? Colors.green : AppColor.accentColor;

    return GestureDetector(
      onTap: isRated ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(top: 10.h, bottom: 4.h),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColor.divider.withOpacity(.55), width: 1),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: color.withOpacity(.10),
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Icon(
                isRated
                    ? Icons.check_circle_rounded
                    : Icons.star_outline_rounded,
                size: 17.sp,
                color: color,
              ),
            ),
            SizedBox(width: 9.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isRated ? 'تم تقييم الطلب' : 'تقييم الطلب',
                    style: StyleManager.font12Weight500.copyWith(
                      color: isRated ? color : AppColor.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    isRated
                        ? 'شكرًا ليك على مشاركة رأيك ❤️'
                        : 'شاركنا رأيك في تجربتك',
                    style: StyleManager.font11Weight400.copyWith(
                      color: AppColor.textSecondary.withOpacity(.85),
                    ),
                  ),
                ],
              ),
            ),
            if (!isRated)
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13.sp,
                color: AppColor.textSecondary.withOpacity(.45),
              ),
            SizedBox(width: 10.w),
          ],
        ),
      ),
    );
  }
}

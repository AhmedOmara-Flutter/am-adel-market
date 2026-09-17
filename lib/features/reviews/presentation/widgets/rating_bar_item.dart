import '../../../../core/utils/app_imports.dart';

class RatingBarItem extends StatelessWidget {
  final int star;
  final double value;

  const RatingBarItem({
    super.key,
    required this.star,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: AppColor.accentColor.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.accentColor.withOpacity(0.25),
              ),
            ),
            child: Center(
              child: Text(
                "$star",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 10.h,
                  backgroundColor: AppColor.border.withOpacity(0.18),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColor.accentColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

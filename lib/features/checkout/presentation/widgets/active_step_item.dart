import '../../../../core/utils/app_imports.dart';

class ActiveStepItem extends StatelessWidget {
  final String text;

  const ActiveStepItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30.w,
          height: 30.w,
          decoration: BoxDecoration(
            color: AppColor.mainColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColor.mainColor.withOpacity(.20),
                blurRadius: 8.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Icon(
            Icons.done_rounded,
            color: AppColor.textOnDark,
            size: 17.sp,
          ),
        ),
        SizedBox(width: 7.w),
        Text(
          text,
          style: StyleManager.font13Weight700.copyWith(
            color: AppColor.mainColor,
          ),
        ),
      ],
    );
  }
}

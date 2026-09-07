import '../../../../core/utils/app_imports.dart';

class ActiveStepItem extends StatelessWidget {
  final String text;

  const ActiveStepItem({
    super.key,
    required this.text,
  });

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
                color: AppColor.mainColor.withOpacity(0.25),
                blurRadius: 8.r,
                offset: Offset(0, 3.h),
              ),
            ],
          ),
          child: Icon(
            Icons.done_rounded,
            color: Colors.white,
            size: 18.sp,
          ),
        ),

        SizedBox(width: 6.w),

        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColor.mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
import '../../../../core/utils/app_imports.dart';

class ValueItem extends StatelessWidget {
  const ValueItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColor.mainColor.withOpacity(0.5),
            size: 32.sp,
          ),

          SizedBox(height: 10.h),

          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColor.mainColor,
            ),
          ),

          SizedBox(height: 8.h),

          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColor.mainColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
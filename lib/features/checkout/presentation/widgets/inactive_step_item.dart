import '../../../../core/utils/app_imports.dart';

class InActiveStepItem extends StatelessWidget {
  final String text;
  final int index;

  const InActiveStepItem({
    super.key,
    required this.text,
    required this.index,
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
            color: AppColor.card,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColor.border,
            ),
          ),
          child: Center(
            child: Text(
              '$index',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: AppColor.textSecondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),

        SizedBox(width: 6.w),

        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: AppColor.textSecondary,
          ),
        ),
      ],
    );
  }
}
import '../../../../core/entities/selected_location_entity.dart';
import '../../../../core/utils/app_imports.dart';

class SelectLocationCard extends StatelessWidget {
  const SelectLocationCard({
    super.key,
    required this.isSelected,
    required this.item,
    this.onTap,
  });

  final VoidCallback? onTap;
  final bool isSelected;
  final SelectedLocationEntity item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.mainColor.withOpacity(.08)
              : AppColor.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected
                ? AppColor.mainColor
                : AppColor.border,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColor.mainColor.withOpacity(.10),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ]
              : [],
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColor.mainColor
                      : AppColor.border,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: const BoxDecoration(
                    color: AppColor.mainColor,
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColor.textPrimary,
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Text(
                    item.subTitle,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: AppColor.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

           SizedBox(width: 10.w),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.mainColor.withOpacity(.08),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                '${item.cost.toStringAsFixed(0)} ج.م',
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
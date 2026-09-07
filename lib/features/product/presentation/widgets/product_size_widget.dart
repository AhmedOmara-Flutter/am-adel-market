import '../../../../core/utils/app_imports.dart';
import '../../../category/domain/entities/category_entity.dart';

class ProductSizeWidget extends StatelessWidget {
  const ProductSizeWidget({
    super.key,
    required this.category,
    required this.selectedSize,
    required this.onSizeSelected,
  });

  final CategoryEntity category;
  final String? selectedSize;
  final ValueChanged<String> onSizeSelected;

  @override
  Widget build(BuildContext context) {
    final sizes = category.sizes;

    if (sizes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 55.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.straighten_outlined,
                size: 20.sp,
                color: AppColor.mainColor,
              ),

              SizedBox(width: 7.w),

              Text(
                'الحجم',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),

          const Spacer(),

          Row(
            mainAxisSize: MainAxisSize.min,
            children: sizes.map((size) {
              final isSelected = selectedSize == size;

              return Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50.r),
                  onTap: () => onSizeSelected(size),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 45.w,
                    height: 45.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.mainColor
                          : AppColor.card,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColor.mainColor
                            : AppColor.border,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      size,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColor.textSecondary,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
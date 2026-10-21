import '../../../../core/utils/app_imports.dart';

class CustomSearchField extends StatelessWidget {
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;
  final BorderSide borderSide;

  const CustomSearchField({
    super.key,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onFilterTap,
    required this.borderSide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          cursorColor: AppColor.mainColor,
          style: StyleManager.font13Weight600.copyWith(
            color: AppColor.textPrimary,
          ),
          decoration: InputDecoration(
            hintText: 'ابحث عن وجبتك المفضلة...',
            hintStyle: StyleManager.font13Weight600.copyWith(
              color: AppColor.textSecondary,
            ),
            filled: true,
            fillColor: AppColor.cardLight,

            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColor.secondaryColor,
              size: 22.sp,
            ),

            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide.none,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide.none,
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: borderSide,
            ),
          ),
        ),
      ),
    );
  }
}

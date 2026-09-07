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
    this.onFilterTap, required this.borderSide,
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
              color: Colors.black.withOpacity(0.05),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: TextFormField(
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          style:StyleManager.font13Weight600,
          cursorColor:AppColor.mainColor ,
          decoration: InputDecoration(
            hintText: 'ابحث عن وجبتك المفضلة...',
            hintStyle:StyleManager.font13Weight600,
            filled: true,
            fillColor: AppColor.card,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: AppColor.mainColor,
              size: 22.sp,
            ),
            suffixIcon: GestureDetector(
              onTap: onFilterTap,
              child: Container(
                margin: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
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
              borderSide:borderSide
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:am_adel_market/core/utils/app_imports.dart';

class CustomReviewFieldSection extends StatelessWidget {
  final TextEditingController controller;
  final void Function()? onSuffixPressed;
  final bool isTyped;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;

  const CustomReviewFieldSection({
    super.key,
    required this.controller,
    this.onSuffixPressed,
    this.isTyped = false,
    this.onChanged,
    this.validator,
    this.autoValidateMode,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final Color fieldColor = Color.alphaBlend(
      AppColor.white.withOpacity(0.35),
      AppColor.backgroundDark,
    );

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: AppColor.accentColor.withOpacity(0.35),
            cursorColor: AppColor.accentColor,
            selectionHandleColor: AppColor.accentColor,
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            validator: validator,
            autovalidateMode: autoValidateMode,

            style: textTheme.titleMedium?.copyWith(
              color: AppColor.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),

            decoration: InputDecoration(
              hintText: 'اكتب التعليق..',

              hintStyle: textTheme.titleMedium?.copyWith(
                color: AppColor.textSecondary.withOpacity(0.75),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),

              filled: true,
              fillColor: fieldColor,

              prefixIcon: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.border.withOpacity(0.65),
                      width: 1.8.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withOpacity(.10),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      Assets.assets.images.customer.path,
                      width: 40.w,
                      height: 40.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              suffixIcon: isTyped
                  ? IconButton(
                      onPressed: onSuffixPressed,
                      icon: Icon(
                        Icons.send_rounded,
                        color: AppColor.accentColor,
                        size: 22.sp,
                      ),
                    )
                  : null,

              contentPadding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 20.h,
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: AppColor.border.withOpacity(0.55),
                  width: 1,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppColor.accentColor,
                  width: 1.8,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColor.red, width: 1.2),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(color: AppColor.red, width: 1.8),
              ),

              errorStyle: textTheme.bodySmall?.copyWith(
                color: AppColor.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),

              errorMaxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}

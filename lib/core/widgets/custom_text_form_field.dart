import 'package:am_adel_market/core/utils/app_imports.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? hintText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final void Function()? onSuffixPressed;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final String? label;
  final bool readOnly;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.hintText,
    this.validator,
    this.autoValidateMode,
    this.onSaved,
    this.onSuffixPressed,
    this.suffixIcon,
    this.prefixIcon,
    this.label,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // لون بني فاتح وهادي للـ TextField
    final Color fieldColor = Color.alphaBlend(
      AppColor.white.withOpacity(0.35),
      AppColor.backgroundDark,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ==============================
        // Label
        // ==============================
        if (label != null) ...[
          Text(
            label!,
            style: textTheme.titleMedium?.copyWith(
              color: AppColor.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
        ],

        // ==============================
        // Text Selection Theme
        // ==============================
        TextSelectionTheme(
          data: TextSelectionThemeData(
            // لون تحديد النص
            selectionColor: AppColor.accentColor.withOpacity(0.35),

            // لون الـ Cursor
            cursorColor: AppColor.accentColor,

            // لون الـ Selection Handles
            selectionHandleColor: AppColor.accentColor,
          ),

          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            autovalidateMode: autoValidateMode,
            onSaved: onSaved,
            readOnly: readOnly,

            style: textTheme.titleMedium?.copyWith(
              color: AppColor.textPrimary,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),

            decoration: InputDecoration(
              // ==========================
              // Hint
              // ==========================
              hintText: hintText,

              hintStyle: textTheme.titleMedium?.copyWith(
                color: AppColor.textSecondary.withOpacity(0.75),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),

              // ==========================
              // Background
              // ==========================
              filled: true,
              fillColor: fieldColor,

              // ==========================
              // Prefix
              // ==========================
              prefixIcon: prefixIcon == null
                  ? null
                  : Icon(
                prefixIcon,
                color: AppColor.secondaryColor,
                size: 24.sp,
              ),

              // ==========================
              // Suffix
              // ==========================
              suffixIcon: suffixIcon == null
                  ? null
                  : IconButton(
                onPressed: onSuffixPressed,
                icon: Icon(
                  suffixIcon,
                  color: AppColor.secondaryColor,
                  size: 24.sp,
                ),
              ),

              // ==========================
              // Padding / Height
              // ==========================
              contentPadding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 20.h,
              ),

              // ==========================
              // Normal Border
              // ==========================
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: AppColor.border.withOpacity(0.55),
                  width: 1,
                ),
              ),

              // ==========================
              // Focus Border
              // ==========================
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppColor.accentColor,
                  width: 1.8,
                ),
              ),

              // ==========================
              // Error Border
              // ==========================
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppColor.red,
                  width: 1.2,
                ),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppColor.red,
                  width: 1.8,
                ),
              ),

              // ==========================
              // Error Text
              // ==========================
              errorStyle: textTheme.bodySmall?.copyWith(
                color: AppColor.red,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),

              errorMaxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}

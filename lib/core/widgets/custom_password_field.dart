import 'package:am_adel_market/core/utils/app_imports.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final AutovalidateMode? autoValidateMode;
  final void Function()? onSuffixTap;
  final void Function(String)? onChange;
  final String? label;

  const CustomPasswordField({
    super.key,
    this.controller,
    this.obscureText = true,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.onSuffixTap,
    this.onChange,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // نفس لون الـ TextFormField العادي
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
            obscureText: obscureText,
            keyboardType: TextInputType.visiblePassword,
            validator: validator,
            onChanged: onChange,
            autovalidateMode: autoValidateMode,

            // ==========================
            // Text
            // ==========================
            style: textTheme.titleMedium?.copyWith(
              color: AppColor.textPrimary,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),

            decoration: InputDecoration(
              // ==========================
              // Hint
              // ==========================
              hintText: 'كلمة المرور',

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
              // Prefix Icon
              // ==========================
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: AppColor.secondaryColor,
                size: 24.sp,
              ),

              // ==========================
              // Suffix Icon
              // ==========================
              suffixIcon: IconButton(
                onPressed: onSuffixTap,
                splashRadius: 24.r,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
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

              // ==========================
              // Focused Error Border
              // ==========================
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

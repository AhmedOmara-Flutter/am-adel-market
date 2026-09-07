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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColor.textPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 6.w),
              Container(
                width: 6.w,
                height: 6.w,
                decoration: const BoxDecoration(
                  color: AppColor.mainColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
        ],

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: TextInputType.visiblePassword,
          validator: validator,
          onChanged: onChange,
          autovalidateMode: autoValidateMode,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColor.textPrimary,
          ),
          cursorColor: AppColor.mainColor,
          decoration: InputDecoration(
            hintText: 'كلمة المرور',
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColor.textSecondary,
            ),

            filled: true,
            fillColor: AppColor.card,

            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: AppColor.mainColor,
              size: 22.sp,
            ),

            suffixIcon: IconButton(
              onPressed: onSuffixTap,
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColor.textSecondary,
                size: 22.sp,
              ),
            ),

            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColor.border,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColor.mainColor,
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColor.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: const BorderSide(
                color: AppColor.red,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
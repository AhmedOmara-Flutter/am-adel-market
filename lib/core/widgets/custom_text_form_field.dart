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
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: autoValidateMode,
          onSaved: onSaved,
          readOnly: readOnly,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
            color: AppColor.textPrimary,
          ),
          cursorColor: AppColor.mainColor,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: AppColor.textSecondary,
            ),

            filled: true,
            fillColor: AppColor.card,

            prefixIcon: prefixIcon == null
                ? null
                : Icon(
              prefixIcon,
              color: AppColor.mainColor,
              size: 22.sp,
            ),

            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
              onPressed: onSuffixPressed,
              icon: Icon(
                suffixIcon,
                color: AppColor.textSecondary,
              ),
            ),

            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14.r),
              borderSide: BorderSide(
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
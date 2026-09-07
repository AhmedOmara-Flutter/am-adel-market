import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/helper_function/get_user.dart';
import '../../../../core/utils/app_imports.dart';

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
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: TextFormField(
          autovalidateMode: autoValidateMode,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          style: Theme
              .of(context)
              .textTheme
              .titleSmall!
              .copyWith(
            color: AppColor.textPrimary,
          ),
          cursorColor: AppColor.mainColor,
          decoration: InputDecoration(
            hintText: 'اكتب التعليق..',
            contentPadding: EdgeInsets.symmetric(vertical: 20.h),
            prefixIcon: Container(
              margin: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 10.w,
              ),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.border, width: 2.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.35),
                      blurRadius: 15.r,
                      offset: Offset(0, 6.h),
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

            hintStyle: Theme
                .of(context)
                .textTheme
                .titleSmall!
                .copyWith(
              color: AppColor.textSecondary,
            ),

            filled: true,
            fillColor: AppColor.card,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColor.border,
              ),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColor.border,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColor.mainColor.withOpacity(.5),
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColor.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(
                color: AppColor.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
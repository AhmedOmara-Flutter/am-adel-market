// import 'package:pizza_sofian_market/core/utils/app_imports.dart';
//
// class CustomAuthField extends StatelessWidget {
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final void Function(String?)? onSaved;
//   final String? hintText;
//   final String? Function(String?)? validator;
//   final AutovalidateMode? autoValidateMode;
//   final void Function()? onSuffixPressed;
//   final IconData? suffixIcon;
//   final IconData? prefixIcon;
//   final String? label;
//   final bool readOnly;
//
//   const CustomAuthField({
//     super.key,
//     this.controller,
//     this.keyboardType,
//     this.hintText,
//     this.validator,
//     this.autoValidateMode,
//     this.onSaved,
//     this.onSuffixPressed,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.label,
//     this.readOnly = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // ================= LABEL =================
//         if (label != null) ...[
//           Row(
//             children: [
//               Text(
//                 label!,
//                 style: theme.textTheme.titleMedium?.copyWith(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(width: 6.w),
//               Container(
//                 width: 6.w,
//                 height: 6.w,
//                 decoration: const BoxDecoration(
//                   color: AppColor.mainColor,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColor.mainColor,
//                       blurRadius: 6,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 9.h),
//         ],
//
//         // ================= TEXT FIELD =================
//         TextFormField(
//           controller: controller,
//           keyboardType: keyboardType,
//           validator: validator,
//           autovalidateMode: autoValidateMode,
//           onSaved: onSaved,
//           readOnly: readOnly,
//
//           style: theme.textTheme.titleSmall?.copyWith(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//           ),
//
//           cursorColor: AppColor.mainColor,
//
//           decoration: InputDecoration(
//             hintText: hintText,
//
//             hintStyle: theme.textTheme.titleSmall?.copyWith(
//               color: Colors.white.withValues(alpha: 0.45),
//               fontWeight: FontWeight.w400,
//             ),
//
//             // ================= BACKGROUND =================
//             filled: true,
//             fillColor: Colors.black.withValues(alpha: 0.72),
//
//             // ================= PREFIX =================
//             prefixIcon: prefixIcon == null
//                 ? null
//                 : Icon(
//               prefixIcon,
//               color: AppColor.mainColor,
//               size: 22.sp,
//             ),
//
//             // ================= SUFFIX =================
//             suffixIcon: suffixIcon == null
//                 ? null
//                 : IconButton(
//               onPressed: onSuffixPressed,
//               splashRadius: 20,
//               icon: Icon(
//                 suffixIcon,
//                 color: Colors.white.withValues(alpha: 0.55),
//               ),
//             ),
//
//             // ================= PADDING =================
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: 16.w,
//               vertical: 16.h,
//             ),
//
//             // ================= NORMAL =================
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: BorderSide(
//                 color: AppColor.mainColor.withValues(alpha: 0.22),
//                 width: 1,
//               ),
//             ),
//
//             // ================= FOCUSED =================
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: const BorderSide(
//                 color: AppColor.mainColor,
//                 width: 1.4,
//               ),
//             ),
//
//             // ================= ERROR =================
//             errorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: const BorderSide(
//                 color: AppColor.red,
//                 width: 1,
//               ),
//             ),
//
//             focusedErrorBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.r),
//               borderSide: const BorderSide(
//                 color: AppColor.red,
//                 width: 1.4,
//               ),
//             ),
//
//             // ================= ERROR TEXT =================
//             errorStyle: theme.textTheme.bodySmall?.copyWith(
//               color: AppColor.red,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
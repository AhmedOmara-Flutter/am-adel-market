// import 'package:pizza_sofian_market/core/utils/app_imports.dart';
//
// class CustomAuthPasswordField extends StatelessWidget {
//   final TextEditingController? controller;
//   final bool obscureText;
//   final String? Function(String?)? validator;
//   final AutovalidateMode? autoValidateMode;
//   final void Function()? onSuffixTap;
//   final void Function(String)? onChange;
//   final String? label;
//
//   const CustomAuthPasswordField({
//     super.key,
//     this.controller,
//     this.obscureText = true,
//     this.validator,
//     this.autoValidateMode = AutovalidateMode.onUserInteraction,
//     this.onSuffixTap,
//     this.onChange,
//     this.label,
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
//         // ================= PASSWORD FIELD =================
//         TextFormField(
//           controller: controller,
//           obscureText: obscureText,
//           keyboardType: TextInputType.visiblePassword,
//           validator: validator,
//           onChanged: onChange,
//           autovalidateMode: autoValidateMode,
//
//           style: theme.textTheme.titleSmall?.copyWith(
//             color: Colors.white,
//             fontWeight: FontWeight.w500,
//           ),
//
//           cursorColor: AppColor.mainColor,
//
//           decoration: InputDecoration(
//             hintText: 'كلمة المرور',
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
//             prefixIcon: Icon(
//               Icons.lock_outline_rounded,
//               color: AppColor.mainColor,
//               size: 22.sp,
//             ),
//
//             // ================= SUFFIX =================
//             suffixIcon: IconButton(
//               onPressed: onSuffixTap,
//               splashRadius: 20,
//               icon: Icon(
//                 obscureText
//                     ? Icons.visibility_off_outlined
//                     : Icons.visibility_outlined,
//                 color: Colors.white.withValues(alpha: 0.55),
//                 size: 22.sp,
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
//             // ================= FOCUSED ERROR =================
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
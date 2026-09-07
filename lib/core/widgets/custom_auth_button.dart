// import 'package:pizza_sofian_market/core/utils/app_imports.dart';
//
// class CustomAuthButton extends StatelessWidget {
//   final Widget child;
//   final VoidCallback? onPressed;
//   final Color? color;
//
//   const CustomAuthButton({
//     super.key,
//     required this.child,
//     this.onPressed,
//     this.color,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: SizedBox(
//         width: double.infinity,
//         height: 54.h,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             // لون شفاف عشان الخلفية تبان
//             backgroundColor: color ??
//                 AppColor.mainColor.withValues(alpha: 0.18),
//
//             foregroundColor: Colors.white,
//
//             disabledBackgroundColor: Colors.white.withValues(
//               alpha: 0.05,
//             ),
//
//             disabledForegroundColor: Colors.white.withValues(
//               alpha: 0.35,
//             ),
//
//             elevation: 0,
//
//             // Border خفيف جدًا
//             side: BorderSide(
//               color: AppColor.mainColor.withValues(alpha: 0.55),
//               width: 1,
//             ),
//
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(15.r),
//             ),
//
//             padding: EdgeInsets.symmetric(
//               horizontal: 20.w,
//               vertical: 14.h,
//             ),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
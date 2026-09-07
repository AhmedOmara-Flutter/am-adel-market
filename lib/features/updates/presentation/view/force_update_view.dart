// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:pizza_sofian_market/core/utils/app_color.dart';
//
// class ForceUpdateView extends StatelessWidget {
//   const ForceUpdateView({
//     super.key,
//     required this.downloadUrl,
//   });
//
//   final String downloadUrl;
//
//   Future<void> _updateApp(BuildContext context) async {
//     final uri = Uri.tryParse(downloadUrl);
//
//     if (uri == null || !uri.hasScheme) {
//       _showMessage(
//         context,
//         'رابط التحديث غير صحيح',
//       );
//       return;
//     }
//
//     try {
//       final launched = await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//
//       if (!launched && context.mounted) {
//         _showMessage(
//           context,
//           'تعذر فتح رابط التحديث',
//         );
//       }
//     } catch (e) {
//       debugPrint('Update URL Error: $e');
//
//       if (context.mounted) {
//         _showMessage(
//           context,
//           'حدث خطأ أثناء فتح رابط التحديث',
//         );
//       }
//     }
//   }
//
//   void _showMessage(
//       BuildContext context,
//       String message,
//       ) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           message,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             color: AppColor.textPrimary,
//             fontSize: 14,
//           ),
//         ),
//         backgroundColor: AppColor.card,
//         behavior: SnackBarBehavior.floating,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(14),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         backgroundColor: AppColor.background,
//         body: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 24,
//                 vertical: 30,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Update Icon
//                   Container(
//                     width: 130,
//                     height: 130,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColor.mainColor.withOpacity(0.12),
//                       border: Border.all(
//                         color: AppColor.mainColor.withOpacity(0.25),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: Container(
//                       margin: const EdgeInsets.all(14),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: AppColor.mainColor,
//                         boxShadow: [
//                           BoxShadow(
//                             color: AppColor.mainColor.withOpacity(0.25),
//                             blurRadius: 25,
//                             spreadRadius: 2,
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.system_update_rounded,
//                         color: AppColor.white,
//                         size: 58,
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 35),
//
//                   // Title
//                   const Text(
//                     'تحديث جديد متاح 🚀',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColor.textPrimary,
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//
//                   const SizedBox(height: 14),
//
//                   // Description
//                   const Text(
//                     'في إصدار جديد من تطبيق بيتزا سفيان جاهز ليك.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColor.textSecondary,
//                       fontSize: 16,
//                       height: 1.7,
//                     ),
//                   ),
//
//                   const SizedBox(height: 6),
//
//                   const Text(
//                     'حدّث التطبيق الآن واستمتع بأحدث المميزات والتحسينات.',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColor.textSecondary,
//                       fontSize: 14,
//                       height: 1.7,
//                     ),
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   // Features Card
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: AppColor.card,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                         color: AppColor.border,
//                       ),
//                     ),
//                     child: Column(
//                       children: [
//                         _buildFeature(
//                           icon: Icons.auto_awesome_rounded,
//                           text: 'تحسينات وأداء أفضل',
//                         ),
//                         const SizedBox(height: 16),
//                         _buildFeature(
//                           icon: Icons.security_rounded,
//                           text: 'تحديثات وتحسينات أمنية',
//                         ),
//                         const SizedBox(height: 16),
//                         _buildFeature(
//                           icon: Icons.restaurant_rounded,
//                           text: 'تجربة أفضل للطلب',
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   // Update Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 58,
//                     child: ElevatedButton(
//                       onPressed: () => _updateApp(context),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColor.mainColor,
//                         foregroundColor: AppColor.white,
//                         elevation: 8,
//                         shadowColor:
//                         AppColor.mainColor.withOpacity(0.3),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(17),
//                         ),
//                       ),
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.download_rounded,
//                             size: 24,
//                           ),
//                           SizedBox(width: 10),
//                           Text(
//                             'تحديث التطبيق الآن',
//                             style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 18),
//
//                   // Required Update
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 14,
//                       vertical: 9,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColor.mainColor.withOpacity(0.08),
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     child: const Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.info_outline_rounded,
//                           color: AppColor.mainColor,
//                           size: 17,
//                         ),
//                         SizedBox(width: 7),
//                         Text(
//                           'التحديث مطلوب للمتابعة',
//                           style: TextStyle(
//                             color: AppColor.mainColor,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 25),
//
//                   const Text(
//                     'شكرًا لاستخدامك بيتزا سفيان ❤️',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColor.textSecondary,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFeature({
//     required IconData icon,
//     required String text,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 42,
//           height: 42,
//           decoration: BoxDecoration(
//             color: AppColor.mainColor.withOpacity(0.12),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(
//             icon,
//             color: AppColor.mainColor,
//             size: 22,
//           ),
//         ),
//         const SizedBox(width: 14),
//         Expanded(
//           child: Text(
//             text,
//             textAlign: TextAlign.right,
//             style: const TextStyle(
//               color: AppColor.textPrimary,
//               fontSize: 14,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         const Icon(
//           Icons.check_circle_rounded,
//           color: AppColor.green,
//           size: 20,
//         ),
//       ],
//     );
//   }
// }
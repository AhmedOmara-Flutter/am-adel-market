//------------------------featured item---------------------------------------
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../../../core/entities/product_entity.dart';
// import '../../../../core/utils/app_imports.dart';
//
// class FeaturedItem extends StatelessWidget {
//   final ProductEntity productEntity;
//
//   const FeaturedItem({super.key, required this.productEntity});
//
//   @override
//   Widget build(BuildContext context) {
//     if (productEntity.isPaused) {
//       return PausedFeaturedItem(productEntity: productEntity);
//     }
//
//     return AvailableFeaturedItem(productEntity: productEntity);
//   }
// }
//
// class AvailableFeaturedItem extends StatelessWidget {
//   final ProductEntity productEntity;
//
//   const AvailableFeaturedItem({super.key, required this.productEntity});
//
//   Future<void> _onTap(BuildContext context) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//
//     await AppSounds.playClickSound('click_song.wav');
//
//     if (!context.mounted) return;
//
//     Navigator.pushNamed(
//       context,
//       RouteManager.productDetails,
//       arguments: productEntity.id,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _onTap(context),
//       child: _FeaturedBody(productEntity: productEntity, paused: false),
//     );
//   }
// }
//
// class PausedFeaturedItem extends StatelessWidget {
//   final ProductEntity productEntity;
//
//   const PausedFeaturedItem({super.key, required this.productEntity});
//
//   @override
//   Widget build(BuildContext context) {
//     return _FeaturedBody(productEntity: productEntity, paused: true);
//   }
// }
//
// class _FeaturedBody extends StatelessWidget {
//   final ProductEntity productEntity;
//   final bool paused;
//
//   const _FeaturedBody({required this.productEntity, required this.paused});
//
//   static const ColorFilter _grayscale = ColorFilter.matrix(<double>[
//     0.2126, 0.7152, 0.0722, 0, 0, //
//     0.2126, 0.7152, 0.0722, 0, 0,
//     0.2126, 0.7152, 0.0722, 0, 0,
//     0, 0, 0, 1, 0,
//   ]);
//
//   @override
//   Widget build(BuildContext context) {
//     final double plateSize = 84.r;
//
//     Widget image = CachedNetworkImage(
//       imageUrl: productEntity.image ?? '',
//       fit: BoxFit.contain,
//       placeholder: (_, __) => Center(
//         child: SizedBox(
//           width: 20.r,
//           height: 20.r,
//           child: const CircularProgressIndicator(
//             color: AppColor.accentColor,
//             strokeWidth: 2,
//           ),
//         ),
//       ),
//       errorWidget: (_, __, ___) => Container(
//         color: AppColor.backgroundDark,
//         alignment: Alignment.center,
//         child: Icon(
//           Icons.fastfood_rounded,
//           size: 32.sp,
//           color: AppColor.secondaryColor,
//         ),
//       ),
//     );
//
//     if (paused) {
//       image = Opacity(
//         opacity: .55,
//         child: ColorFiltered(colorFilter: _grayscale, child: image),
//       );
//     }
//
//     return SizedBox(
//       width: 112.w,
//       height: 158.h,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topCenter,
//         children: [
//           Positioned(
//             top: 40.h,
//             child: Container(
//               width: 110.w,
//               height: 118.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(55.w),
//                   topRight: Radius.circular(55.w),
//                   bottomLeft: Radius.circular(22.r),
//                   bottomRight: Radius.circular(22.r),
//                 ),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: paused
//                       ? [AppColor.backgroundDark, AppColor.background]
//                       : [AppColor.white, AppColor.cardLight, AppColor.background],
//                 ),
//                 border: Border.all(
//                   color: paused
//                       ? AppColor.divider.withOpacity(.20)
//                       : AppColor.divider.withOpacity(0.25),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColor.mainColor.withOpacity(paused ? .08 : .16),
//                     blurRadius: 10.r,
//                     offset: Offset(0, 8.h),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: 50.h,
//                   left: 8.w,
//                   right: 8.w,
//                   bottom: 8.h,
//                 ),
//                 child: Column(
//                   children: [
//                     // فاصل زخرفي: خط ◆ خط
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 18.w,
//                           height: 1,
//                           color: AppColor.accentColor.withOpacity(.55),
//                         ),
//                         SizedBox(width: 5.w),
//                         Transform.rotate(
//                           angle: 0.785398,
//                           child: Container(
//                             width: 5.r,
//                             height: 5.r,
//                             color: paused
//                                 ? AppColor.border
//                                 : AppColor.accentColor,
//                           ),
//                         ),
//                         SizedBox(width: 5.w),
//                         Container(
//                           width: 18.w,
//                           height: 1,
//                           color: AppColor.accentColor.withOpacity(.55),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           productEntity.name,
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: StyleManager.font14Weight600.copyWith(
//                             color: paused
//                                 ? AppColor.textSecondary.withOpacity(.7)
//                                 : AppColor.textPrimary,
//                             height: 1.2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           Positioned(
//             top: 0,
//             child: Container(
//               width: plateSize,
//               height: plateSize,
//               padding: EdgeInsets.all(3.r),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: paused
//                       ? [AppColor.divider, AppColor.border]
//                       : [
//                     AppColor.goldLight,
//                     AppColor.accentColor,
//                     AppColor.goldLight,
//                   ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColor.mainColor.withOpacity(.22),
//                     blurRadius: 14.r,
//                     offset: Offset(0, 6.h),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(2.r),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColor.white,
//                 ),
//                 child: ClipOval(child: image),
//               ),
//             ),
//           ),
//
//           if (paused)
//             Positioned(
//               top: plateSize - 14.h,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: AppColor.red,
//                   borderRadius: BorderRadius.circular(20.r),
//                   border: Border.all(color: AppColor.white, width: 1.5),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColor.red.withOpacity(.35),
//                       blurRadius: 8.r,
//                       offset: Offset(0, 3.h),
//                     ),
//                   ],
//                 ),
//                 child: Text(
//                   'غير متوفر حاليًا',
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   style: StyleManager.font11Weight400.copyWith(
//                     color: AppColor.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

//-----------------------------------------------------------


//import 'package:cached_network_image/cached_network_image.dart';
// import '../../../../core/entities/product_entity.dart';
// import '../../../../core/utils/app_imports.dart';
//
// class FeaturedItem extends StatelessWidget {
//   final ProductEntity productEntity;
//
//   const FeaturedItem({super.key, required this.productEntity});
//
//   @override
//   Widget build(BuildContext context) {
//     if (productEntity.isPaused) {
//       return PausedFeaturedItem(productEntity: productEntity);
//     }
//
//     return AvailableFeaturedItem(productEntity: productEntity);
//   }
// }
//
// class AvailableFeaturedItem extends StatelessWidget {
//   final ProductEntity productEntity;
//
//   const AvailableFeaturedItem({super.key, required this.productEntity});
//
//   Future<void> _onTap(BuildContext context) async {
//     FocusManager.instance.primaryFocus?.unfocus();
//
//     await AppSounds.playClickSound('click_song.wav');
//
//     if (!context.mounted) return;
//
//     Navigator.pushNamed(
//       context,
//       RouteManager.productDetails,
//       arguments: productEntity.id,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => _onTap(context),
//       child: _FeaturedBody(productEntity: productEntity, paused: false),
//     );
//   }
// }
//
// class PausedFeaturedItem extends StatelessWidget {
//   final ProductEntity productEntity;
//
//   const PausedFeaturedItem({super.key, required this.productEntity});
//
//   @override
//   Widget build(BuildContext context) {
//     return _FeaturedBody(productEntity: productEntity, paused: true);
//   }
// }
//
// /// الشكل المشترك (فاتح): كارت كريمي على شكل قوس + طبق دائري بإطار ذهبي.
// class _FeaturedBody extends StatelessWidget {
//   final ProductEntity productEntity;
//   final bool paused;
//
//   const _FeaturedBody({required this.productEntity, required this.paused});
//
//   static const ColorFilter _grayscale = ColorFilter.matrix(<double>[
//     0.2126, 0.7152, 0.0722, 0, 0, //
//     0.2126, 0.7152, 0.0722, 0, 0,
//     0.2126, 0.7152, 0.0722, 0, 0,
//     0, 0, 0, 1, 0,
//   ]);
//
//   @override
//   Widget build(BuildContext context) {
//     final double plateSize = 84.r;
//
//     Widget image = CachedNetworkImage(
//       imageUrl: productEntity.image ?? '',
//       fit: BoxFit.cover,
//       placeholder: (_, __) => Center(
//         child: SizedBox(
//           width: 20.r,
//           height: 20.r,
//           child: const CircularProgressIndicator(
//             color: AppColor.accentColor,
//             strokeWidth: 2,
//           ),
//         ),
//       ),
//       errorWidget: (_, __, ___) => Container(
//         color: AppColor.backgroundDark,
//         alignment: Alignment.center,
//         child: Icon(
//           Icons.fastfood_rounded,
//           size: 32.sp,
//           color: AppColor.secondaryColor,
//         ),
//       ),
//     );
//
//     if (paused) {
//       image = Opacity(
//         opacity: .55,
//         child: ColorFiltered(colorFilter: _grayscale, child: image),
//       );
//     }
//
//     return SizedBox(
//       width: 112.w,
//       height: 158.h,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.topCenter,
//         children: [
//           // ===== الكارت (قوس كريمي فاتح) =====
//           Positioned(
//             top: 40.h,
//             child: Container(
//               width: 110.w,
//               height: 118.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(55.w),
//                   topRight: Radius.circular(55.w),
//                   bottomLeft: Radius.circular(22.r),
//                   bottomRight: Radius.circular(22.r),
//                 ),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: paused
//                       ? [AppColor.backgroundDark, AppColor.background]
//                       : [AppColor.white, AppColor.cardLight, AppColor.background],
//                 ),
//                 border: Border.all(
//                   color: paused
//                       ? AppColor.divider.withOpacity(.6)
//                       : AppColor.accentColor.withOpacity(.55),
//                   width: 1,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColor.mainColor.withOpacity(paused ? .08 : .16),
//                     blurRadius: 16.r,
//                     offset: Offset(0, 8.h),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(
//                   top: 50.h,
//                   left: 8.w,
//                   right: 8.w,
//                   bottom: 8.h,
//                 ),
//                 child: Column(
//                   children: [
//                     // فاصل زخرفي: خط ◆ خط
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           width: 18.w,
//                           height: 1,
//                           color: AppColor.accentColor.withOpacity(.55),
//                         ),
//                         SizedBox(width: 5.w),
//                         Transform.rotate(
//                           angle: 0.785398,
//                           child: Container(
//                             width: 5.r,
//                             height: 5.r,
//                             color: paused
//                                 ? AppColor.border
//                                 : AppColor.accentColor,
//                           ),
//                         ),
//                         SizedBox(width: 5.w),
//                         Container(
//                           width: 18.w,
//                           height: 1,
//                           color: AppColor.accentColor.withOpacity(.55),
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: Center(
//                         child: Text(
//                           productEntity.name,
//                           textAlign: TextAlign.center,
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: StyleManager.font14Weight600.copyWith(
//                             color: paused
//                                 ? AppColor.textSecondary.withOpacity(.7)
//                                 : AppColor.textPrimary,
//                             height: 1.2,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // ===== الطبق (الصورة) بإطار ذهبي =====
//           Positioned(
//             top: 0,
//             child: Container(
//               width: plateSize,
//               height: plateSize,
//               padding: EdgeInsets.all(3.r),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: paused
//                       ? [AppColor.divider, AppColor.border]
//                       : [
//                           AppColor.goldLight,
//                           AppColor.accentColor,
//                           AppColor.goldLight,
//                         ],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColor.mainColor.withOpacity(.22),
//                     blurRadius: 14.r,
//                     offset: Offset(0, 6.h),
//                   ),
//                 ],
//               ),
//               child: Container(
//                 padding: EdgeInsets.all(2.r),
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColor.white,
//                 ),
//                 child: ClipOval(child: image),
//               ),
//             ),
//           ),
//
//           // ===== شريط "غير متوفر" =====
//           if (paused)
//             Positioned(
//               top: plateSize - 14.h,
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
//                 decoration: BoxDecoration(
//                   color: AppColor.red,
//                   borderRadius: BorderRadius.circular(20.r),
//                   border: Border.all(color: AppColor.white, width: 1.5),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColor.red.withOpacity(.35),
//                       blurRadius: 8.r,
//                       offset: Offset(0, 3.h),
//                     ),
//                   ],
//                 ),
//                 child: Text(
//                   'غير متوفر حاليًا',
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   style: StyleManager.font11Weight400.copyWith(
//                     color: AppColor.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

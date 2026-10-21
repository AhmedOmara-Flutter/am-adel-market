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

//---------------------------------offer item///////////////////////
//import 'dart:math' as math;
// import 'package:am_adel_market/core/utils/app_imports.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../core/entities/offer_entity.dart';
//
// /// بانر العرض بطابع المطاعم (فاتح):
// /// صورة بحافة منحنية ذهبية على الشمال + ختم خصم مموّج + محتوى على اليمين
// /// (شارة، اسم، خط منقط، سعر جديد/قديم، زرار "اطلب الآن") + تأثير ضغط.
// class OfferCarouselItem extends StatefulWidget {
//   final OfferEntity offer;
//
//   const OfferCarouselItem({super.key, required this.offer});
//
//   @override
//   State<OfferCarouselItem> createState() => _OfferCarouselItemState();
// }
//
// class _OfferCarouselItemState extends State<OfferCarouselItem> {
//   bool _pressed = false;
//
//   void _setPressed(bool value) {
//     if (_pressed == value) return;
//     setState(() => _pressed = value);
//   }
//
//   void _openDetails() {
//     Navigator.pushNamed(
//       context,
//       RouteManager.productDetails,
//       arguments: widget.offer.productId,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final offer = widget.offer;
//     final double imageWidth = 150.w;
//
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTapDown: (_) => _setPressed(true),
//         onTapUp: (_) => _setPressed(false),
//         onTapCancel: () => _setPressed(false),
//         onTap: _openDetails,
//         child: AnimatedScale(
//           scale: _pressed ? .98 : 1,
//           duration: const Duration(milliseconds: 120),
//           curve: Curves.easeOut,
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//             height: 180.h,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(26.r),
//               gradient: const LinearGradient(
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//                 colors: [
//                   AppColor.white,
//                   AppColor.cardLight,
//                   AppColor.background,
//                 ],
//               ),
//               border: Border.all(
//                 color: AppColor.divider.withOpacity(.85),
//                 width: 1,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: AppColor.mainColor.withOpacity(.18),
//                   blurRadius: 22.r,
//                   offset: Offset(0, 10.h),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(26.r),
//               child: Stack(
//                 children: [
//                   // ===== زخرفة خلفية باهتة =====
//                   Positioned(
//                     right: -34.r,
//                     bottom: -34.r,
//                     child: Icon(
//                       Icons.restaurant_rounded,
//                       size: 140.r,
//                       color: AppColor.accentColor.withOpacity(.08),
//                     ),
//                   ),
//
//                   // ===== إطار ذهبي داخلي (شكل المنيو) =====
//                   Positioned.fill(
//                     child: Container(
//                       margin: EdgeInsets.all(5.r),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(21.r),
//                         border: Border.all(
//                           color: AppColor.accentColor.withOpacity(.32),
//                           width: 1,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // ===== الصورة (شمال) بحافة منحنية =====
//                   Positioned(
//                     left: 0,
//                     top: 0,
//                     bottom: 0,
//                     width: imageWidth,
//                     child: Stack(
//                       children: [
//                         Positioned.fill(
//                           child: ClipPath(
//                             clipper: _CurvedEdgeClipper(),
//                             child: Stack(
//                               fit: StackFit.expand,
//                               children: [
//                                 CachedNetworkImage(
//                                   imageUrl: offer.image,
//                                   fit: BoxFit.cover,
//                                   placeholder: (context, url) =>
//                                       Shimmer.fromColors(
//                                         baseColor: AppColor.backgroundDark,
//                                         highlightColor: AppColor.cardLight,
//                                         child: Container(
//                                           color: AppColor.backgroundDark,
//                                         ),
//                                       ),
//                                   errorWidget: (context, url, error) =>
//                                       Container(
//                                         color: AppColor.backgroundDark,
//                                         alignment: Alignment.center,
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             Icon(
//                                               Icons.cloud_off_rounded,
//                                               color: AppColor.secondaryColor,
//                                               size: 30.sp,
//                                             ),
//                                             SizedBox(height: 6.h),
//                                             Text(
//                                               "تعذر تحميل الصورة",
//                                               style: StyleManager
//                                                   .font12Weight500
//                                                   .copyWith(
//                                                 color:
//                                                 AppColor.textSecondary,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                 ),
//                                 // تدرج خفيف أسفل الصورة لإحساس بالعمق
//                                 DecoratedBox(
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       begin: Alignment.bottomCenter,
//                                       end: Alignment.center,
//                                       colors: [
//                                         AppColor.black.withOpacity(.30),
//                                         AppColor.transparent,
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//
//                         // خط ذهبي رفيع على الحافة المنحنية
//                         Positioned.fill(
//                           child: CustomPaint(painter: _EdgeStrokePainter()),
//                         ),
//
//                         // ختم الخصم المموّج
//                         Positioned(
//                           top: 12.h,
//                           left: 12.w,
//                           child: Transform.rotate(
//                             angle: -0.18,
//                             child: _DiscountSeal(
//                               percentage: '${offer.discountPercentage}',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   // ===== المحتوى (يمين) =====
//                   Positioned.fill(
//                     child: Padding(
//                       padding: EdgeInsets.fromLTRB(
//                         imageWidth + 4.w,
//                         16.h,
//                         18.w,
//                         16.h,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // شارة "عرض الشيف"
//                           Container(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: 10.w,
//                               vertical: 4.h,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColor.accentColor.withOpacity(.14),
//                               borderRadius: BorderRadius.circular(20.r),
//                               border: Border.all(
//                                 color: AppColor.accentColor.withOpacity(.45),
//                               ),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.restaurant_menu_rounded,
//                                   color: AppColor.secondaryColor,
//                                   size: 13.sp,
//                                 ),
//                                 SizedBox(width: 5.w),
//                                 Text(
//                                   "عرض الشيف",
//                                   style: StyleManager.font11Weight400.copyWith(
//                                     color: AppColor.secondaryColor,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           // الاسم + خط منقط + الأسعار
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 offer.name,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: StyleManager.font18Weight700.copyWith(
//                                   color: AppColor.textPrimary,
//                                   height: 1.2,
//                                 ),
//                               ),
//                               SizedBox(height: 5.h),
//                               Row(
//                                 children: List.generate(
//                                   24,
//                                       (i) => Expanded(
//                                     child: Container(
//                                       height: 1.2,
//                                       margin: EdgeInsets.symmetric(
//                                         horizontal: 1.3.w,
//                                       ),
//                                       color: AppColor.border.withOpacity(.55),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 5.h),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     "${offer.priceAfterDiscount} ج.م",
//                                     style: StyleManager.font19Weight700
//                                         .copyWith(color: AppColor.mainColor),
//                                   ),
//                                   SizedBox(width: 8.w),
//                                   Padding(
//                                     padding: EdgeInsets.only(bottom: 2.h),
//                                     child: Text(
//                                       "${offer.priceBeforeDiscount} ج.م",
//                                       style: StyleManager.font13Weight400
//                                           .copyWith(
//                                         color: AppColor.textSecondary,
//                                         decoration:
//                                         TextDecoration.lineThrough,
//                                         decorationColor: AppColor.red,
//                                         decorationThickness: 1.8,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//
//                           // زرار "اطلب الآن" (شكل فقط، الكارت كله بيفتح التفاصيل)
//                           Container(
//                             padding: EdgeInsets.only(
//                               right: 16.w,
//                               left: 5.w,
//                               top: 4.h,
//                               bottom: 4.h,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(22.r),
//                               gradient: const LinearGradient(
//                                 begin: Alignment.topLeft,
//                                 end: Alignment.bottomRight,
//                                 colors: [
//                                   AppColor.goldLight,
//                                   AppColor.accentColor,
//                                 ],
//                               ),
//                               border: Border.all(
//                                 color: AppColor.white,
//                                 width: 1.6,
//                               ),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColor.accentColor.withOpacity(.5),
//                                   blurRadius: 12.r,
//                                   offset: Offset(0, 5.h),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   "اطلب الآن",
//                                   style: StyleManager.font14Weight600.copyWith(
//                                     color: AppColor.mainColor,
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                                 SizedBox(width: 10.w),
//                                 Container(
//                                   width: 26.r,
//                                   height: 26.r,
//                                   decoration: const BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: AppColor.mainColor,
//                                   ),
//                                   child: Icon(
//                                     Icons.arrow_back_rounded,
//                                     color: AppColor.goldLight,
//                                     size: 16.sp,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
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
// }
//
// /// ختم الخصم: دايرة ذهبية بحافة مموّجة.
// class _DiscountSeal extends StatelessWidget {
//   final String percentage;
//
//   const _DiscountSeal({required this.percentage});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 66.r,
//       height: 66.r,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           Positioned.fill(child: CustomPaint(painter: _ScallopSealPainter())),
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'خصم',
//                 style: StyleManager.font12Weight500.copyWith(
//                   color: AppColor.mainColor,
//                   fontSize: 10.sp,
//                   fontWeight: FontWeight.w700,
//                   height: 1,
//                 ),
//               ),
//               SizedBox(height: 2.h),
//               Text(
//                 '$percentage%',
//                 style: StyleManager.font23Weight700.copyWith(
//                   color: AppColor.mainColor,
//                   fontSize: 19.sp,
//                   fontWeight: FontWeight.w900,
//                   height: 1,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ScallopSealPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Offset center = size.center(Offset.zero);
//     final double radius = size.width / 2 - 3;
//     const int bumps = 16;
//
//     final Path path = Path();
//     for (int i = 0; i <= 360; i++) {
//       final double theta = i * math.pi / 180;
//       final double r = radius * (0.94 + 0.06 * math.cos(bumps * theta));
//       final double x = center.dx + r * math.cos(theta);
//       final double y = center.dy + r * math.sin(theta);
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }
//     path.close();
//
//     canvas.drawShadow(path, AppColor.accentColor, 6, true);
//
//     canvas.drawPath(
//       path,
//       Paint()
//         ..style = PaintingStyle.fill
//         ..shader = const LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [AppColor.goldLight, AppColor.accentColor],
//         ).createShader(Offset.zero & size),
//     );
//
//     canvas.drawPath(
//       path,
//       Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2.2
//         ..color = AppColor.white,
//     );
//
//     canvas.drawCircle(
//       center,
//       radius * 0.78,
//       Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 1
//         ..color = AppColor.mainColor.withOpacity(.28),
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
//
// /// يقص الصورة بحيث تكون حافتها اليمنى (ناحية المحتوى) منحنية بشكل محدب.
// class _CurvedEdgeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     return Path()
//       ..moveTo(0, 0)
//       ..lineTo(size.width - 34, 0)
//       ..quadraticBezierTo(
//         size.width + 6,
//         size.height / 2,
//         size.width - 34,
//         size.height,
//       )
//       ..lineTo(0, size.height)
//       ..close();
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
//
// /// خط ذهبي رفيع بيمشي على نفس الحافة المنحنية.
// class _EdgeStrokePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Path edge = Path()
//       ..moveTo(size.width - 34, 0)
//       ..quadraticBezierTo(
//         size.width + 6,
//         size.height / 2,
//         size.width - 34,
//         size.height,
//       );
//
//     canvas.drawPath(
//       edge,
//       Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 2.4
//         ..color = AppColor.white,
//     );
//     canvas.drawPath(
//       edge,
//       Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 1.2
//         ..color = AppColor.accentColor.withOpacity(.85),
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }
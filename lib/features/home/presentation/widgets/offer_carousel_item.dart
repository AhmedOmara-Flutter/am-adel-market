import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/entities/offer_entity.dart';

class OfferCarouselItem extends StatelessWidget {
  final OfferEntity offer;

  const OfferCarouselItem({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteManager.productDetails,
          arguments: offer.productId,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        height: 180.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: AppColor.divider.withOpacity(0.25),
            width: 1.w,
          ),
        ),        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: offer.image,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColor.card,
                    highlightColor: AppColor.cardLight,
                    child: Container(color: AppColor.card),
                  ),
                  errorWidget: (context, url, error) => Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.card,
                          borderRadius: BorderRadius.circular(22.r),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_off_rounded,
                            color: AppColor.goldLight,
                            size: 34.sp,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "تعذر تحميل الصورة",
                            style: StyleManager.font12Weight500.copyWith(
                              color: AppColor.textOnDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// Image Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColor.black.withOpacity(.48),
                        AppColor.black.withOpacity(.25),
                        AppColor.black.withOpacity(.08),
                        AppColor.transparent,
                      ],
                      stops: const [
                        0.0,
                        .35,
                        .70,
                        1.0,
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.w),
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 7.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                  color: AppColor.goldLight.withOpacity(.35),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.black.withOpacity(.25),
                                    blurRadius: 10.r,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.local_offer_rounded,
                                    color: AppColor.goldLight,
                                    size: 14.sp,
                                  ),

                                  SizedBox(width: 5.w),

                                  Text(
                                    "خصم ${offer.discountPercentage}%",
                                    style: StyleManager.font11Weight400
                                        .copyWith(
                                          color: AppColor.textOnDark,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: .3,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.card.withOpacity(.88),
                                borderRadius: BorderRadius.circular(14.r),
                                border: Border.all(
                                  color: AppColor.border.withOpacity(.45),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer.name,
                                    style: StyleManager.font18Weight700
                                        .copyWith(color: AppColor.textOnDark),
                                  ),

                                  SizedBox(height: 6.h),

                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "${offer.priceAfterDiscount} ج.م",
                                        style: StyleManager.font19Weight700
                                            .copyWith(
                                              color: AppColor.goldLight,
                                            ),
                                      ),

                                      SizedBox(width: 8.w),

                                      Text(
                                        "${offer.priceBeforeDiscount} ج.م",
                                        style: StyleManager.font13Weight400
                                            .copyWith(
                                              color: AppColor.accentColor,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              decorationColor:
                                                  AppColor.accentColor,
                                              decorationThickness: 1.4,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(30.r),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteManager.productDetails,
                                  arguments: offer.productId,
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 18.w,
                                  vertical: 11.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.goldLight,
                                  borderRadius: BorderRadius.circular(30.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.black.withOpacity(.25),
                                      blurRadius: 12.r,
                                      offset: Offset(0, 6.h),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "اطلب الآن",
                                      style: StyleManager.font14Weight600
                                          .copyWith(color: AppColor.mainColor),
                                    ),

                                    SizedBox(width: 8.w),

                                    Icon(
                                      Icons.arrow_back,
                                      color: AppColor.mainColor,
                                      size: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';

class AvailableFeaturedItem extends StatefulWidget {
  final ProductEntity productEntity;

  const AvailableFeaturedItem({super.key, required this.productEntity});

  @override
  State<AvailableFeaturedItem> createState() => _AvailableFeaturedItemState();
}

class _AvailableFeaturedItemState extends State<AvailableFeaturedItem> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  Future<void> _onTap() async {
    FocusManager.instance.primaryFocus?.unfocus();

    await AppSounds.playClickSound('click_song.wav');

    if (!mounted) return;

    Navigator.pushNamed(
      context,
      RouteManager.productDetails,
      arguments: widget.productEntity.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double plateSize = 82.r;
    final double plateTop = 6.h;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: _onTap,
      child: AnimatedScale(
        scale: _pressed ? .95 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: SizedBox(
          width: 112.w,
          height: 158.h,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              // ===== الكارت =====
              Positioned(
                top: 48.h,
                child: Container(
                  width: 110.w,
                  height: 102.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.white,
                        AppColor.cardLight,
                        AppColor.background,
                      ],
                    ),
                    border: Border.all(
                      color: AppColor.divider.withOpacity(.25),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.mainColor.withOpacity(.14),
                        blurRadius: 18.r,
                        offset: Offset(0, 9.h),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26.r),
                    child: Stack(
                      children: [
                        // زخرفة: دايرة كبيرة باهتة في الركن
                        Positioned(
                          right: -22.r,
                          bottom: -22.r,
                          child: Container(
                            width: 70.r,
                            height: 70.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.accentColor.withOpacity(.09),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -14.r,
                          top: 30.r,
                          child: Container(
                            width: 36.r,
                            height: 36.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColor.accentColor.withOpacity(.18),
                                width: 1.2,
                              ),
                            ),
                          ),
                        ),

                        // اسم المنتج
                        Padding(
                          padding: EdgeInsets.only(
                            top: 46.h,
                            left: 8.w,
                            right: 8.w,
                            bottom: 20.h,
                          ),
                          child: Center(
                            child: Text(
                              widget.productEntity.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font14Weight600.copyWith(
                                color: AppColor.textPrimary,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // ===== الطبق (الصورة) =====
              Positioned(
                top: plateTop,
                child: Container(
                  width: plateSize,
                  height: plateSize,
                  padding: EdgeInsets.all(3.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white,
                    border: Border.all(color: AppColor.accentColor, width: 1.4),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.mainColor.withOpacity(.20),
                        blurRadius: 14.r,
                        offset: Offset(0, 6.h),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: widget.productEntity.image ?? '',
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Center(
                        child: SizedBox(
                          width: 20.r,
                          height: 20.r,
                          child: const CircularProgressIndicator(
                            color: AppColor.accentColor,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: AppColor.backgroundDark,
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.fastfood_rounded,
                          size: 32.sp,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // ===== نجمة ذهبية على الطبق =====
              Positioned(
                top: plateTop - 2.h,
                right: 8.w,
                child: Container(
                  width: 24.r,
                  height: 24.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColor.goldLight, AppColor.accentColor],
                    ),
                    border: Border.all(color: AppColor.white, width: 1.8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.accentColor.withOpacity(.45),
                        blurRadius: 8.r,
                        offset: Offset(0, 3.h),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.star_rounded,
                    size: 14.sp,
                    color: AppColor.mainColor,
                  ),
                ),
              ),

              // ===== زرار "اطلب الآن" عايم على حرف الكارت =====
              Positioned(
                bottom: 0,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColor.goldLight, AppColor.accentColor],
                      ),
                      border: Border.all(color: AppColor.white, width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'اطلب الآن',
                          style: StyleManager.font11Weight400.copyWith(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          Icons.arrow_back_rounded,
                          size: 13.sp,
                          color: AppColor.mainColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
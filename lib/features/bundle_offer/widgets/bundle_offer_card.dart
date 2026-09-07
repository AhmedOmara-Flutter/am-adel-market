import 'package:cached_network_image/cached_network_image.dart';
import 'package:am_adel_market/core/entities/bundle_offer_entity.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

import '../../../core/helper_function/get_user.dart';
import '../../cart/presentation/view_model/cart_cubit.dart';
import '../../restaurant_status/presentation/view_model/restaurant_status_cubit.dart';

class BundleOfferCard extends StatelessWidget {
  final BundleOfferEntity bundleOffer;

  const BundleOfferCard({
    super.key,
    required this.bundleOffer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 35.h,
        left: 6.w,
        right: 6.w,
        bottom: 8.h,
      ),
      child: SizedBox(
        width: 220.w,
        height: 245.h,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                width: 220.w,
                height: 245.h,
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.card,
                    borderRadius: BorderRadius.circular(19.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.black.withOpacity(.30),
                        blurRadius: 10.r,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15.r),
                                bottomLeft: Radius.circular(15.r),
                              ),
                            ),
                            child: Tooltip(
                              triggerMode: TooltipTriggerMode.tap,
                              message: bundleOffer.description,
                              waitDuration:
                              const Duration(milliseconds: 100),
                              showDuration:
                              const Duration(seconds: 4),
                              preferBelow: false,
                              verticalOffset: 10.h,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              textStyle:
                              StyleManager.font13Weight400.copyWith(
                                color: AppColor.white,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.card,
                                borderRadius:
                                BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColor.mainColor
                                      .withOpacity(.2),
                                  width: 1.w,
                                ),
                              ),
                              child: SizedBox(
                                width: 34.w,
                                height: 34.h,
                                child: Icon(
                                  Icons.info_outline,
                                  color: AppColor.white,
                                  size: 21.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: CachedNetworkImage(
                          imageUrl: bundleOffer.image ?? '',
                          width: double.infinity,
                          height: 125.h,
                          fit: BoxFit.contain,
                          placeholder: (_, __) {
                            return Center(
                              child: SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child:
                                const CircularProgressIndicator(
                                  color: AppColor.mainColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                          errorWidget: (_, __, ___) {
                            return SizedBox(
                              width: double.infinity,
                              height: 125.h,
                              child: Icon(
                                Icons.fastfood_rounded,
                                size: 36.sp,
                                color: AppColor.textSecondary,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        width: double.infinity,
                        height: 46.h,
                        child: Material(
                          color: AppColor.transparent,
                          borderRadius: BorderRadius.circular(23.r),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(23.r),
                            onTap: () {
                              context.read<CartCubit>().addBundleOffer(
                                bundleOffer,
                                getUser().uId,
                              );
                            },
                            child: Ink(
                              padding: EdgeInsets.only(
                                right: 18.w,
                                left: 8.w,
                                top: 3.h,
                                bottom: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColor.card,
                                borderRadius: BorderRadius.circular(30.r),
                                border: Border.all(
                                  color: AppColor.border,
                                  width: 1.w,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      bundleOffer.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: StyleManager.font14Weight600.copyWith(
                                        color: AppColor.textPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Container(
                                    width: 35.w,
                                    height: 35.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.mainColor.withOpacity(.20),
                                          blurRadius: 6.r,
                                          offset: Offset(0, 2.h),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: AppColor.white,
                                      size: 18.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -25.h,
              left: -10.w,
              child: BundleOfferPriceBadge(
                price: bundleOffer.price,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BundleOfferPriceBadge extends StatelessWidget {
  final double price;

  const BundleOfferPriceBadge({
    super.key,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 105.w,
      height: 70.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.assets.images.bedgeImage.path,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 3.h,
              bottom: 2.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'سعر خاص',
                  style: StyleManager.font12Weight500.copyWith(
                    color: AppColor.black,
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(height: 0.h),

                Text(
                  price.toStringAsFixed(0),
                  style: StyleManager.font23Weight700.copyWith(
                    color: AppColor.white,
                    fontSize: 23.sp,
                    height: .9,
                  ),
                ),

                Text(
                  'ج.م',
                  style: StyleManager.font12Weight500.copyWith(
                    color: AppColor.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    height: .9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
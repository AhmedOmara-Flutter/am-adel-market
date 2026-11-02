import 'dart:math' as math;

import '../../../../core/utils/app_imports.dart';

/// عنوان قسم "لقمتك على مزاجك" بنفس طابع المنيو الذهبي:
/// أيقونة ذهبية + عنوان + فاصل زخرفي بيتلاشى.
class BundleOfferSection extends StatelessWidget {
  const BundleOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w,bottom: 20.h),
      child: Row(
        children: [
          Container(
            width: 30.r,
            height: 30.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.goldLight, AppColor.accentColor],
              ),
              border: Border.all(color: AppColor.white, width: 1.6),
              boxShadow: [
                BoxShadow(
                  color: AppColor.accentColor.withValues(alpha: .4),
                  blurRadius: 8.r,
                  offset: Offset(0, 3.h),
                ),
              ],
            ),
            child: Icon(
              Icons.card_giftcard_rounded,
              size: 16.sp,
              color: AppColor.mainColor,
            ),
          ),
          SizedBox(width: 10.w),

          Text(
            'لقمتك على مزاجك',
            style: StyleManager.font16Weight700.copyWith(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(width: 10.w),

          // فاصل زخرفي بياخد باقي المساحة
          const Expanded(child: _OrnamentLine()),
        ],
      ),
    );
  }
}

/// خط ذهبي بيتلاشى ومعاه ◆ في الأول
class _OrnamentLine extends StatelessWidget {
  const _OrnamentLine();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 6.r,
            height: 6.r,
            color: AppColor.accentColor,
          ),
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColor.accentColor.withValues(alpha: .6),
                  AppColor.accentColor.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
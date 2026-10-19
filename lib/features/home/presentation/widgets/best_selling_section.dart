import 'dart:math' as math;
import 'package:am_adel_market/core/utils/app_imports.dart';

/// عنوان قسم "الأكثر طلبًا" بنفس طابع المنيو الذهبي:
/// نجمة ذهبية + عنوان + فاصل زخرفي بيتلاشى + زرار "المزيد" كبسولة ذهبية.
class BestSellingSection extends StatelessWidget {
  const BestSellingSection({super.key});

  void _openMore(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.pushNamed(context, RouteManager.bestSellingMore);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
      child: Row(
        children: [
          // نجمة ذهبية (بدل إيموجي ⭐ عشان تبان واحدة على كل الأجهزة)
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
              Icons.star_rounded,
              size: 17.sp,
              color: AppColor.mainColor,
            ),
          ),
          SizedBox(width: 10.w),

          Text(
            'الأكثر طلبًا',
            style: StyleManager.font16Weight700.copyWith(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(width: 10.w),

          // فاصل زخرفي بياخد المساحة اللي في النص
          const Expanded(child: _OrnamentLine()),
          SizedBox(width: 10.w),

          // زرار "المزيد"
          Material(
            color: AppColor.transparent,
            borderRadius: BorderRadius.circular(20.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: () => _openMore(context),
              child: Ink(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColor.accentColor.withValues(alpha: .10),
                  border: Border.all(
                    color: AppColor.accentColor.withValues(alpha: .55),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'المزيد',
                      style: StyleManager.font14Weight600.copyWith(
                        color: AppColor.mainColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_back_rounded,
                      size: 15.sp,
                      color: AppColor.mainColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
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
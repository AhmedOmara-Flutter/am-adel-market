import 'package:am_adel_market/core/utils/app_imports.dart';

class StringManager {

  static Widget onBoardingTitle1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'طعم البيت.. ',
          style:StyleManager.font28Weight700.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w800,

          )
        ),
        Text(
          'على أصوله',
            style:StyleManager.font28Weight700.copyWith(
              color: AppColor.accentColor,
              fontWeight: FontWeight.w800,

            )
        ),
      ],
    );
  }
  static Widget onBoardingTitle2(BuildContext context) {
    return Text('ابحث وتسوق', style: Theme
        .of(context)
        .textTheme
        .titleLarge);
  }


  static const onBoardingDescription1 =
      'من أول حبة فول لحد آخر قرمشة في الطعمية، '
      '\nكل حاجة بتحضر بعناية وبطعم مصري أصيل، '
      '\nعشان كل وجبة تبدأ معاها يومك بمزاج';

  static const onBoardingDescription2 =
      'اكتشف تشكيلة متنوعة من الكريب الحلو والحادق،\n'
      'واختر مكوناتك المفضلة بكل سهولة مع تجربة\n'
      'طلب سريعة وممتعة.';
}

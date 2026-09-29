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

  static const onBoardingDescription1 =
      'من أول حبة فول لحد آخر قرمشة في الطعمية، '
      '\nكل حاجة بتحضر بعناية وبطعم مصري أصيل، '
      '\nعشان كل وجبة تبدأ معاها يومك بمزاج';



  static Widget onBoardingTitle2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'أشهى الأكلات.. ',
          style: StyleManager.font28Weight700.copyWith(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          'بين إيديك',
          style: StyleManager.font28Weight700.copyWith(
            color: AppColor.accentColor,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  static const onBoardingDescription2 =
      'استمتع بأشهى الوجبات والمكونات الطازجة،\n'
      'واختار طلبك المفضل بكل سهولة،\n'
      'وخلي طعم البيت يوصل لحد عندك.';

}

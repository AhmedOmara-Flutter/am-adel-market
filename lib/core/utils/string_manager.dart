import 'package:am_adel_market/core/utils/app_imports.dart';

class StringManager {

  static Widget onBoardingTitle1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('مرحبًا بك في ', style: Theme
            .of(context)
            .textTheme
            .titleLarge,),
        Text('بيتزا ', style: Theme
            .of(context)
            .textTheme
            .titleLarge!
            .copyWith(
            color: Color(0xffF4A91F)
        )
        ),
        Text('سفيان', style: Theme
            .of(context)
            .textTheme
            .titleLarge!
            .copyWith(
            color: AppColor.mainColor
        )),
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
      'استمتع بأشهى أنواع البيتزا المحضرة بمكونات\n'
      'طازجة وجودة عالية، مع نكهات مميزة وعروض\n'
      'تناسب جميع الأذواق.';

  static const onBoardingDescription2 =
      'اكتشف تشكيلة متنوعة من الكريب الحلو والحادق،\n'
      'واختر مكوناتك المفضلة بكل سهولة مع تجربة\n'
      'طلب سريعة وممتعة.';
}

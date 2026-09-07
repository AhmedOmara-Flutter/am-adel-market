import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingBackground extends StatelessWidget {
  final String background;
  const OnBoardingBackground({
    super.key, required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(background,fit: BoxFit.fill,),
      ],
    );
  }
}

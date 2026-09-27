import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingDescription extends StatelessWidget {
  final String description;
  const OnBoardingDescription({
    super.key, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      description,
      style: StyleManager.font12Weight500,

    );
  }
}

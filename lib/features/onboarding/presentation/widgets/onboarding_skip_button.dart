import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingSkipButton extends StatelessWidget {
  const OnBoardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: GestureDetector(onTap: () {
          onBoardingViewed();
          Navigator.pushReplacementNamed(context, RouteManager.login);
        }, child: Text('تخط', style: Theme
            .of(context)
            .textTheme
            .titleSmall,)),
      ),
    );
  }
}

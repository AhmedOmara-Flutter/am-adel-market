import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingPageIndicator extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  const OnBoardingPageIndicator({
    super.key, required this.currentIndex, required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount, (index) => CustomDot(isActive: currentIndex == index),)
    );
  }
}

class CustomDot extends StatelessWidget {
  final bool isActive;

  const CustomDot({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 15 : 12,
      height: isActive ? 15 : 12,
      decoration: BoxDecoration(
        color: isActive
            ?  AppColor.mainColor
            : AppColor.mainColor.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}
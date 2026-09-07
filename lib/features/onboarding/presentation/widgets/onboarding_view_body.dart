import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  int currentIndex = 0;
  late List<PageViewModel> items = [
    PageViewModel(
      image: Assets.assets.images.pizza.path,
      title: StringManager.onBoardingTitle1(context),
      description: StringManager.onBoardingDescription1,
      background: Assets.assets.images.onboardingBackground1.path,
    ),
    PageViewModel(
      image: Assets.assets.images.crepe.path,
      title: StringManager.onBoardingTitle2(context),
      description: StringManager.onBoardingDescription2,
      background: Assets.assets.images.onboardingBackground2.path,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assets.images.onboarding2.path),
          fit: BoxFit.contain,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Material(
                color: AppColor.transparent,
                child: InkWell(
                  onTap: () {
                    onBoardingViewed();
                    Navigator.pushReplacementNamed(context, RouteManager.login);
                  },
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.mainColor,
                    ),

                    child: Center(
                      child: Text(
                        'ابدا',
                        style: StyleManager.font15Weight800.copyWith(
                          color: AppColor.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

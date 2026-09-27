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
        image: Assets.assets.images.onboardingLogo.path,
        title: StringManager.onBoardingTitle1(context),
        description: StringManager.onBoardingDescription1,
        background: Assets.assets.images.onboardingBackground1.path
    ),

    PageViewModel(image: Assets.assets.images.onboardingLogo.path,
        title: StringManager.onBoardingTitle2(context),
        description: StringManager.onBoardingDescription2,
        background: Assets.assets.images.onboardingBackground2.path
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .width * 1.77,
          child: PageView.builder(
            itemBuilder: (context, index) =>
                PageViewItem(pageViewModel: items[index],
                  currentIndex: currentIndex,
                  pageCount: items.length,),
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: items.length,
          ),
        ),

        OnBoardingPageIndicator(
          currentIndex: currentIndex,
          pageCount: items.length,
        ),
        const SizedBox(height: 30),
        if(currentIndex == items.length - 1)
          CustomButton(child: Text('ابدأ الان',
              style: StyleManager.font15Weight800.copyWith(
                  color: AppColor.white)), onPressed: () {
            onBoardingViewed();
            Navigator.pushReplacementNamed(context, RouteManager.login);
          },),
      ],
    );
  }
}


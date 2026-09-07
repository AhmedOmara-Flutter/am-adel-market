import 'package:am_adel_market/core/utils/app_imports.dart';

class PageViewItem extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  final PageViewModel pageViewModel;


  const PageViewItem({
    super.key, required this.pageViewModel, required this.currentIndex, required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
      Stack(
      alignment: Alignment.topCenter,
      children: [
        OnBoardingBackground(
          background: pageViewModel.background,
        ),

        OnBoardingImage(
          image: pageViewModel.image,
        ),

        if (currentIndex != pageCount - 1)
          const OnBoardingSkipButton(),
      ],
    ),
        SizedBox(height: 50),
        OnBoardingContent(pageViewModel: pageViewModel,),
      ],
    );
  }
}

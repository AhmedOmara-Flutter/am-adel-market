import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingContent extends StatelessWidget {
  final PageViewModel pageViewModel;

  const OnBoardingContent({
    super.key, required this.pageViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          OnBoardingTitle(title: pageViewModel.title,),
          SizedBox(height: 30,),
          OnBoardingDescription(description: pageViewModel.description,),
        ],
      ),
    );
  }
}

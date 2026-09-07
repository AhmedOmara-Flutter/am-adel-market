import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingDescription extends StatelessWidget {
  final String description;
  const OnBoardingDescription({
    super.key, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
       description,style:Theme.of(context).textTheme.titleMedium!.copyWith(
      height: 1.7
    ),
     textAlign: TextAlign.center,

    );
  }
}

import 'package:am_adel_market/core/utils/app_imports.dart';

class CustomSocialButton extends StatelessWidget {
  final String image;
  final String text;
  final void Function() onPressed;

  const CustomSocialButton({
    super.key,
    required this.image,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SvgPicture.asset(image, width: 20, height: 20),
            ),
            Text(text, style: Theme.of(context).textTheme.labelMedium),
          ],
        ),
      ),
    );
  }
}

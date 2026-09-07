import '../../../../core/utils/app_imports.dart';
import 'active_step_item.dart';
import 'inactive_step_item.dart';

class CheckoutStepperItem extends StatelessWidget {
  final String text;
  final int index;
  final int currentIndex;

  const CheckoutStepperItem({
    super.key,
    required this.text,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    // step الحالي
    if (index == currentIndex ) {
      return ActiveStepItem(text: text);
    }

    // step خلص
    if (index < currentIndex ) {
      return ActiveStepItem(text: text);
    }

    // step لسه
    return InActiveStepItem(
      text: text,
      index: index+1,
    );

  }
}

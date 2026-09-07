import '../../../../core/utils/app_imports.dart';
import 'checkout_stepper_item.dart';

class CheckoutStepper extends StatelessWidget {
  final int currentIndex;
  final List<String> stepperTitles;

  const CheckoutStepper({
    super.key,
    required this.currentIndex,
    required this.stepperTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        stepperTitles.length,
        (index) => GestureDetector(
          child: CheckoutStepperItem(
            currentIndex: currentIndex,
            index: index,
            text: stepperTitles[index],
          ),
        ),
      ),
    );
  }
}

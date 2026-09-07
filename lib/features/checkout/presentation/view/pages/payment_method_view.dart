import 'package:am_adel_market/features/checkout/presentation/view_model/checkout_cubit.dart';

import '../../../../../core/utils/app_imports.dart';
import '../../widgets/payment_method/payment_method_button_section.dart';
import '../../widgets/payment_method/payment_method_section.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentMethodSection(),
              PaymentMethodButtonSection(),
              SizedBox(height: 30.h),
            ],
          ),
        );
      },
    );
  }
}
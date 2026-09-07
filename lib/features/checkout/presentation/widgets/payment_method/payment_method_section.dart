import 'package:am_adel_market/features/checkout/presentation/widgets/selection_card.dart';

import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';

class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CheckoutCubit>();
    return Expanded(
      child: ListView.separated(
        itemCount: cubit.paymentOptions.length,
        separatorBuilder: (_, _) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final item = cubit.paymentOptions[index];
          final isSelected = cubit.isCashOnDelivery == (index == 0);
          return SelectionCard(
            isSelected: isSelected,
            item: item,
            onTap: () {
              cubit.selectShipping(index == 0);
            },
          );
        },
      ),
    );
  }
}

import 'package:am_adel_market/features/checkout/presentation/view_model/checkout_cubit.dart';

import '../../../../../core/helper_function/custom_show_dialog.dart';
import '../../../../../core/utils/app_imports.dart';

class OrderReviewButtonSection extends StatelessWidget {
  const OrderReviewButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutCubit, CheckoutState>(
      builder: (context, state) {
        final cubit = context.read<CheckoutCubit>();
        return CustomButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            CustomShowDialog.show(
              context,
              title: 'تأكيد الدفع',
              content: Text(
                'هل أنت متأكد من إتمام عملية الدفع؟',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.grey),
              ),
              accept: () async {
                Navigator.pop(context);
                cubit.orderEntity.orderNote =
                    cubit.notesController.text.trim();
                await cubit.addOrder(cubit.orderEntity);
              },
              cancel: () {
                Navigator.pop(context);
              },
            );
          },
          child: Text(
            'تاكيد الطلب',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        );
      },
    );
  }
}

class ShowAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function()? cancel;
  final void Function()? accept;

  const ShowAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancel,
    this.accept,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: AppColor.mainColor.withOpacity(0.08),
            child: const Icon(
              Icons.payment_rounded,
              color: AppColor.mainColor,
              size: 35,
            ),
          ),
          const SizedBox(height: 20),
          Text(title, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 10),
          Text(
            content,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onLongPress: () {},
                  child: Text(
                    'إلغاء',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: accept,
                  child: Text(
                    'تأكيد',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import '../../../../core/utils/app_imports.dart';
import 'coupon_list_view.dart';

class CouponViewBody extends StatelessWidget {
  const CouponViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoActionRow(
          text: 'كوبوناتي',
          showBack: true,
          bottomPadding: 0.0,
        ),
        const SizedBox(height: 10),
        const Expanded(
          child: CouponListView(),
        ),
      ],
    );
  }
}
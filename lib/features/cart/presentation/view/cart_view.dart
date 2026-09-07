import 'package:am_adel_market/core/helper_function/get_user.dart';

import '../../../../../../../core/utils/app_imports.dart';
import '../view_model/cart_cubit.dart';
import '../widgets/cart_view_body.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().loadCart(getUser().uId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: CartViewBody());
  }
}

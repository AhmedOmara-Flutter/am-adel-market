import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/core/widgets/custom_refresh_indicator.dart';
import 'package:am_adel_market/features/offers/presentation/view_model/offer_cubit.dart';
import 'package:am_adel_market/features/product/presentation/widgets/category_tabs.dart';
import '../../../../../../../core/utils/app_imports.dart';
import '../../../../core/cubit/product_cubit/product_cubit.dart';
import '../../../home/presentation/view_model/best_selling_cubit.dart';
import '../../../home/presentation/view_model/featured_cubit.dart';

class ProductViewBody extends StatefulWidget {
  const ProductViewBody({super.key});

  @override
  State<ProductViewBody> createState() => _ProductViewBodyState();
}

class _ProductViewBodyState extends State<ProductViewBody> {

  @override
  void initState() {
    context.read<ProductCubit>().getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoActionRow(
          text: 'المنتجات',
          showSearch: true,
          searchOnPressed: () {
            Navigator.pushNamed(context, RouteManager.search);
          },
        ),
        Expanded(child: CategoryTabs()),
      ],
    );
  }
}

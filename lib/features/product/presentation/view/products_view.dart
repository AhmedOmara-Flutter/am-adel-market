import 'package:am_adel_market/features/product/presentation/widgets/product_view_body.dart';
import 'package:flutter/services.dart';
import '../../../../../../../core/utils/app_imports.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ) ,
    child: ProductViewBody());
  }
}

import 'package:flutter/services.dart';
import 'package:am_adel_market/features/product_details/presentation/widgets/product_details_view_body.dart';

import '../../../../core/utils/app_imports.dart';

class ProductDetailsView extends StatelessWidget {
  final String productId;

  const ProductDetailsView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(body: ProductDetailsViewBody(productId: productId),),
    );
  }
}

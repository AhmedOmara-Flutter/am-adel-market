import 'package:am_adel_market/features/offers/presentation/view_model/offer_cubit.dart';
import 'package:am_adel_market/features/product_details/presentation/widgets/product_button_section.dart';
import 'package:am_adel_market/features/product_details/presentation/widgets/product_details_section.dart';
import 'package:am_adel_market/features/product_details/presentation/widgets/product_image_section.dart';
import 'package:am_adel_market/features/product_details/presentation/widgets/product_sub_images_section.dart';
import '../../../../core/cubit/product_cubit/product_cubit.dart';
import '../../../../core/utils/app_imports.dart';

class ProductDetailsViewBody extends StatelessWidget {
  final String productId;

  const ProductDetailsViewBody({super.key, required this.productId});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductsSuccessState) {
          final product = state.products.firstWhere(
            (p) => p.id == productId,
            orElse: () => throw Exception("المنتج غير موجود"),
          );

          final offer = context.watch<OfferCubit>().offersMap[product.id];

          return CustomScrollView(
            slivers: [
              ProductImageSection(product: product, offer: offer),
              SliverToBoxAdapter(child: SizedBox(height: 10.h)),
              ProductSubImagesSection(product: product),
              ProductDetailsSection(product: product, offer: offer),
              ProductButtonSection(product: product, offer: offer),
            ],
          );
        }

        if (state is GetProductsErrorState) {
          return Center(child: Text(state.errMessage));
        }

        return const Center(
          child: CircularProgressIndicator(color: AppColor.mainColor),
        );
      },
    );
  }
}

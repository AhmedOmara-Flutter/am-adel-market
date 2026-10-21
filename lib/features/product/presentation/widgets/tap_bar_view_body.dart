import 'package:am_adel_market/core/widgets/empty_widget.dart';
import '../../../../core/cubit/product_cubit/product_cubit.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/product_item.dart';
import '../../../../core/widgets/skeletonizer_product_item.dart';

class TapBarViewBody extends StatelessWidget {
  final String category;
  final String? size;

  const TapBarViewBody({super.key, required this.category, this.size});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final ProductCubit cubit = context.read<ProductCubit>();

        var products = cubit.allProducts
            .where((product) => product.category == category)
            .toList();

        if (size != null) {
          products = products.where((product) => product.size == size).toList();
        }

        if (state is GetProductsLoadingState)
          return GridView.builder(
            padding: EdgeInsets.only(left: 20.w, top: 10.h,right: 20.w, bottom: 20.h),
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              return SkeletonizerProductItem();
            },
          );


        if (state is GetFilteredProductsError) {
          return Center(child: Text(state.errMessage));
        }

        if (products.isEmpty) {
          return const EmptyWidget();
        }

        return GridView.builder(
          padding: EdgeInsets.only(left: 20.w, top: 10.h,right: 20.w, bottom: 20.h),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .70,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
          ),
          itemBuilder: (context, index) {
            return ProductItem(product: products[index]);
          },
        );
      },
    );
  }
}

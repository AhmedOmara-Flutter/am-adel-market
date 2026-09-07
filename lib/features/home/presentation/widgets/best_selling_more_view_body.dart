import 'package:am_adel_market/features/home/presentation/view_model/best_selling_cubit.dart';

import '../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/products_grid_view.dart';

class BestSellingMoreViewBody extends StatefulWidget {
  const BestSellingMoreViewBody({super.key});

  @override
  State<BestSellingMoreViewBody> createState() =>
      _BestSellingMoreViewBodyState();
}

class _BestSellingMoreViewBodyState extends State<BestSellingMoreViewBody> {
  @override
  void initState() {
    final cubit = context.read<BestSellingCubit>();

      cubit.getSellingProducts();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: InfoActionRow(text: '⭐ الأكثر طلبًا',
              showBack: true),
        ),
        BlocBuilder<BestSellingCubit, BestSellingState>(
          builder: (context, state) {
            if (state is GetSellingProductsLoadingState) {
              return Skeletonizer.sliver(
                effect: ShimmerEffect(
                  baseColor: const Color(0xff2B2B2B),
                  highlightColor: const Color(0xff404040),
                  duration: const Duration(milliseconds: 1200),
                ),
                enabled: true,
                child: ProductsGridView(products: getDummyProducts()),
              );
            }

            if (state is GetSellingProductsEmptyState) {
              print('EMPTY UI BUILT');

              return  SliverFillRemaining(
                hasScrollBody: false,
                child:  Center(
                  child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 10,top: 10),
                      child: Text(
                        'لا يوجد حاليا منتجات برجاء الاضافه', style: Theme
                          .of(context)
                          .textTheme
                          .labelLarge!.copyWith(
                      ),
                        textAlign: TextAlign.center,
                      )),
                ),
              );
            }

            if (state is GetSellingProductsSuccessState) {
              return ProductsGridView(products: state.sellingProducts);
            }

            if (state is GetSellingProductsErrorState) {
              return SliverToBoxAdapter(
                child: Center(child: Text(state.errMessage)),
              );
            }

            return const SliverToBoxAdapter(child: SizedBox.shrink());
          },
        ),
      ],
    );
  }
}

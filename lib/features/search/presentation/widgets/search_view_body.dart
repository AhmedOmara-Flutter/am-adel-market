import 'package:am_adel_market/core/widgets/products_grid_view.dart';
import 'package:am_adel_market/features/search/presentation/view_model/search_cubit.dart';
import 'package:am_adel_market/features/search/presentation/widgets/build_search_initial.dart';
import 'package:am_adel_market/features/search/presentation/widgets/custom_search_field.dart';

import '../../../../core/utils/app_imports.dart';
import 'build_search_empty.dart';
import 'build_search_success.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(instance()),
      child: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InfoActionRow(text: 'بحث', showBack: true),
                    CustomSearchField(
                      borderSide: BorderSide(
                        color: AppColor.mainColor.withOpacity(0.25),
                        width: 1.2,
                      ),
                      onChanged: (value) {
                        context.read<SearchCubit>().search(value);
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
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

                  if (state is SearchSuccess) {
                    return BuildSearchSuccess(products: state.products);
                  }

                  if (state is SearchEmpty) {
                    return BuildSearchEmpty(query: state.query);
                  }

                  if (state is SearchError) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text(state.errMessage)),
                    );
                  }

                  return BuildSearchInitial();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/features/flash_offers/presentation/view/flash_offer_section.dart';
import 'package:am_adel_market/features/flash_offers/presentation/view_model/get_flash_offer_cubit/get_flash_offer_cubit.dart';
import 'package:am_adel_market/features/flash_offers/presentation/widgets/flash_offer_list.dart';
import 'package:am_adel_market/features/home/presentation/view_model/best_selling_cubit.dart';
import 'package:am_adel_market/features/home/presentation/view_model/featured_cubit.dart';
import 'package:am_adel_market/features/home/presentation/widgets/best_selling_section.dart';
import 'package:am_adel_market/features/home/presentation/widgets/offer_carousel_list.dart';
import 'package:am_adel_market/features/home/presentation/widgets/home_header.dart';
import 'package:am_adel_market/features/home/presentation/widgets/featured_products_section.dart';
import 'package:am_adel_market/features/search/presentation/widgets/custom_search_field.dart';
import '../../../../../../../core/utils/app_imports.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../bundle_offer/view/bundle_offer_section.dart';
import '../../../bundle_offer/view_model/get_bundle_offer_cubit/get_bundle_offer_cubit.dart';
import '../../../bundle_offer/widgets/bundle_offer_list.dart';
import '../../../offers/presentation/view_model/offer_cubit.dart';
import 'restaurant_closed_banner.dart';
import 'best_selling_products_list.dart';
import 'featured_products_list.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BestSellingCubit>().getSellingProducts();
      context.read<FeaturedCubit>().getFeaturedProducts();
      context.read<OfferCubit>().getOffers();
      context.read<GetBundleOfferCubit>().getBundleOffers();
      context.read<GetFlashOfferCubit>().getFlashOffers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final offers = context
        .watch<OfferCubit>()
        .offers
        .where((e) => e.isActive)
        .toList();

    return CustomRefreshIndicator(
      onRefresh: () async {
        final bestSellingCubit = context.read<BestSellingCubit>();
        final featuredCubit = context.read<FeaturedCubit>();
        final offerCubit = context.read<OfferCubit>();
        final bundleOfferCubit = context.read<GetBundleOfferCubit>();
        final flashOfferCubit = context.read<GetFlashOfferCubit>();
        bundleOfferCubit.getBundleOffers();
        bestSellingCubit.getSellingProducts();
        featuredCubit.getFeaturedProducts();
        offerCubit.getOffers();
        flashOfferCubit.getFlashOffers();
        getUser();
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(),
                RestaurantClosedBanner(),
                if (offers.isEmpty)
                  Column(
                    children: [
                      SizedBox(height: 15,),
                      CustomSearchField(
                        borderSide: BorderSide.none,
                        readOnly: true,
                        onTap: () {
                          Navigator.pushNamed(context, RouteManager.search);
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                OfferCarouselList(),
                FeaturedProductsSection(),
                FeaturedProductsList(),
                SizedBox(height:20.h,),
                if(context.watch<GetBundleOfferCubit>().bundleOffers.isNotEmpty)
                  Column(
                    children: [
                      BundleOfferSection(),
                      BundleOfferList(),
                    ],
                  ),
                if(context.watch<GetFlashOfferCubit>().flashOffers.isNotEmpty)
                  Column(
                    children: [
                      FlashOfferSection(),
                      SizedBox(height: 20,),
                      FlashOfferList(),
                      SizedBox(height: 20,)
                    ],
                  ),
                BestSellingSection(),
              ],
            ),
          ),
          BestSellingProductsList(),
          SliverToBoxAdapter(child: SizedBox(height: 20.h))
        ],
      ),
    );
  }
}

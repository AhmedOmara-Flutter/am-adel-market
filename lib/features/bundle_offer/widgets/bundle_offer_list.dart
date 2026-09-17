import 'package:am_adel_market/features/bundle_offer/widgets/skeletonizer_bundle_offer_card.dart';

import '../../../core/utils/app_imports.dart';
import '../view_model/get_bundle_offer_cubit/get_bundle_offer_cubit.dart';
import 'bundle_offer_card.dart';

class BundleOfferList extends StatelessWidget {
  const BundleOfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetBundleOfferCubit, GetBundleOfferState>(
      builder: (context, state) {
        // =============================================================
        // LOADING
        // =============================================================
        if (state is GetBundleOfferLoading) {
          return Skeletonizer(
            effect: const ShimmerEffect(
              baseColor: Color(0xff2B2B2B),
              highlightColor: Color(0xff404040),
              duration: Duration(milliseconds: 1200),
            ),
            enabled: true,
            child: SizedBox(
              height: 310.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return const SkeletonizerBundleOfferCard();
                },
              ),
            ),
          );
        }

        // =============================================================
        // FAILURE
        // =============================================================
        if (state is GetBundleOfferFailure) {
          return SizedBox(
            height: 310.h,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                child: Text(
                  state.errMessage,
                  textAlign: TextAlign.center,
                  style: StyleManager.font14Weight600.copyWith(
                    color: AppColor.red,
                  ),
                ),
              ),
            ),
          );
        }

        // =============================================================
        // SUCCESS
        // =============================================================
        if (state is GetBundleOfferSuccess) {
          final bundleOffers = state.bundleOffers;

          // No offers
          if (bundleOffers.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 310.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: bundleOffers.length,
              itemBuilder: (context, index) {
                final bundleOffer = bundleOffers[index];

                return Column(
                  children: [
                    SizedBox(height: 20.h),
                    BundleOfferCard(
                      bundleOffer: bundleOffer,
                    ),
                  ],
                );
              },
            ),
          );
        }

        // =============================================================
        // INITIAL
        // =============================================================
        return const SizedBox.shrink();
      },
    );
  }
}
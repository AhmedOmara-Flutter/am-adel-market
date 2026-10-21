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
        if (state is GetBundleOfferLoading)
          return SizedBox(
            height: 270.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: Constants.screenHorizontal,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: 4,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    SkeletonizerBundleOfferCard(),
                  ],
                );
              },
            ),
          );

        if (state is GetBundleOfferFailure) {
          return SizedBox(
            height: 270.h,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.screenHorizontal
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

        if (state is GetBundleOfferSuccess) {
          final bundleOffers = state.bundleOffers;

          if (bundleOffers.isEmpty) {
            return const SizedBox.shrink();
          }

          return SizedBox(
            height: 270.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                horizontal: Constants.screenHorizontal,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: bundleOffers.length,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                final bundleOffer = bundleOffers[index];

                return Column(
                  children: [
                    BundleOfferCard(
                      bundleOffer: bundleOffer,
                    ),
                  ],
                );
              },
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
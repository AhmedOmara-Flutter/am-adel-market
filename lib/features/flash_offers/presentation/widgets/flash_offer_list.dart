import 'package:carousel_slider/carousel_slider.dart';

import '../../../../core/utils/app_imports.dart';
import '../view_model/get_flash_offer_cubit/get_flash_offer_cubit.dart';
import 'flash_offer_card.dart';
import 'skeletonizer_flash_offer_card.dart';

class FlashOfferList extends StatelessWidget {
  const FlashOfferList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFlashOfferCubit, GetFlashOfferState>(
      builder: (context, state) {
        if (state is GetFlashOfferLoading) {
          return CarouselSlider.builder(
            itemCount: 4,
            itemBuilder: (context, index, realIndex) {
              return const SkeletonizerFlashOfferCard();
            },
            options: CarouselOptions(
              height: 115.h,
              viewportFraction: 0.90,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 700),
              autoPlayCurve: Curves.easeInOut,
              enableInfiniteScroll: true,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          );
        }

        if (state is GetFlashOfferFailure) {
          return SizedBox(
            height: 180.h,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
        if (state is GetFlashOfferSuccess) {
          final flashOffers = state.flashOffers;

          if (flashOffers.isEmpty) {
            return const SizedBox.shrink();
          }

          return CarouselSlider.builder(
            itemCount: flashOffers.length,
            itemBuilder: (context, index, realIndex) {
              return FlashOfferCard(flashOffer: flashOffers[index]);
            },
            options: CarouselOptions(
              height: 115.h,
              viewportFraction: 0.90,
              enlargeCenterPage: false,
              autoPlay: flashOffers.length > 1,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 700),
              autoPlayCurve: Curves.easeInOut,
              enableInfiniteScroll: flashOffers.length > 1,
              scrollPhysics: const BouncingScrollPhysics(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

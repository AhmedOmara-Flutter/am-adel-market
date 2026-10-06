import 'package:carousel_slider/carousel_slider.dart';
import 'package:am_adel_market/features/home/presentation/widgets/offer_carousel_item.dart';
import 'package:am_adel_market/features/home/presentation/widgets/skeletonizer_offer_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../offers/presentation/view_model/offer_cubit.dart';

class OfferCarouselList extends StatefulWidget {
  const OfferCarouselList({super.key});

  @override
  State<OfferCarouselList> createState() => _OfferCarouselListState();
}

class _OfferCarouselListState extends State<OfferCarouselList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        if (state is GetOffersLoading) {
          return _buildLoading();
        }

        if (state is GetOffersFailure) {
          return Center(
            child: Text(state.errMessage, style: TextStyle(fontSize: 14.sp)),
          );
        }

        if (state is GetOffersSuccess) {
          final offers = state.offers.where((e) => e.isActive).toList();

          if (offers.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            children: [
              SizedBox(height: 20.h),

              CarouselSlider.builder(
                itemCount: offers.length,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: OfferCarouselItem(offer: offers[index]),
                  );
                },
                options: _carouselOptions(),
              ),

              SizedBox(height: 5.h),
              AnimatedSmoothIndicator(
                activeIndex: currentIndex,
                count: offers.length,
                effect: SwapEffect(
                  activeDotColor: AppColor.mainColor,
                  dotColor: Colors.grey.shade300,
                  dotHeight: 8.r,
                  dotWidth: 8.r,
                ),
              ),

              SizedBox(height: 12.h),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoading() {
    return Column(
      children: [
        SizedBox(height: 20.h),

        CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, index, realIndex) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SkeletonizerOfferItem(),
            );
          },
          options: _carouselOptions(),
        ),

        SizedBox(height: 5.h),

        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: 3,
          effect: SwapEffect(
            activeDotColor: AppColor.mainColor,
            dotColor: AppColor.backgroundDark,
            dotHeight: 8.r,
            dotWidth: 8.r,
          ),
        ),

        SizedBox(height: 12.h),
      ],
    );
  }

  CarouselOptions _carouselOptions() {
    return CarouselOptions(
      height: 230.h,
      viewportFraction: 1,
      initialPage: 0,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 4),
      autoPlayAnimationDuration: const Duration(milliseconds: 600),
      autoPlayCurve: Curves.easeInOut,
      enlargeCenterPage: false,
      enableInfiniteScroll: true,
      padEnds: true,
      clipBehavior: Clip.none,
      scrollPhysics: const BouncingScrollPhysics(),
      onPageChanged: (index, reason) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}

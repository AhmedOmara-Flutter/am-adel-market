import '../../../../core/utils/app_imports.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomReviewBarSection extends StatelessWidget {
  final void Function(double) ratingUpdate;
  final double initialRate;

  const CustomReviewBarSection({
    super.key,
    required this.ratingUpdate,
    required this.initialRate,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 10.h,
              bottom: 20.h,
            ),
            child: RatingBar.builder(
              initialRating: initialRate,
              minRating: 1,
              direction: Axis.horizontal,
              unratedColor: AppColor.mainColor.withOpacity(0.25),
              itemCount: 5,
              itemSize: 40.w,
              itemPadding: EdgeInsets.symmetric(horizontal: 5.w),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: AppColor.mainColor,
              ),
              onRatingUpdate: ratingUpdate,
              updateOnDrag: true,
            ),
          ),
        ],
      ),
    );
  }
}
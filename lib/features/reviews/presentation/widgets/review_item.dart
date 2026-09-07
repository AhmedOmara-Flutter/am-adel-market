import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/review_entity.dart';
class ReviewItem extends StatelessWidget {
  final ReviewEntity review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
        decoration: BoxDecoration(
        shape: BoxShape.circle,
          border: Border.all(color: AppColor.border, width: 2.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.35),
              blurRadius: 15.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            Assets.assets.images.customer.path,
            width: 50.w,
            height: 50.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.name,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          Text(
                            review.date,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffFFC529),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            review.rating.toString(),
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    review.reviewDescription,
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

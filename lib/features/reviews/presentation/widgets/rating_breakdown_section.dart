import 'package:am_adel_market/features/reviews/presentation/widgets/rating_bar_item.dart';
import '../../../../core/utils/app_imports.dart';
import '../view_model/get_review_cubit/get_review_cubit.dart';

class RatingBreakdownSection extends StatelessWidget {
  const RatingBreakdownSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetReviewCubit>();

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15.h),

            Text(
              "${cubit.reviews.length} مراجعة",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: AppColor.textPrimary,
              ),
            ),

            SizedBox(height: 10.h),

            Align(
              alignment: Alignment.center,
              child: Text(
                'الملخص',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ),

            SizedBox(height: 16.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.card,
                    borderRadius: BorderRadius.circular(18.r),
                    border: Border.all(
                      color: AppColor.border,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: AppColor.mainColor,
                        size: 30.sp,
                      ),

                      SizedBox(height: 6.h),

                      Text(
                        cubit.averageRating.toString(),
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4.h),

                      Text(
                        "${cubit.recommendedPercentage}%",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 2.h),

                      Text(
                        "موصى بها",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 18.w),

                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.card,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: AppColor.border,
                      ),
                    ),
                    child: Column(
                      children: [
                        RatingBarItem(
                          star: 5,
                          value: cubit.getPercentage(5),
                        ),
                        RatingBarItem(
                          star: 4,
                          value: cubit.getPercentage(4),
                        ),
                        RatingBarItem(
                          star: 3,
                          value: cubit.getPercentage(3),
                        ),
                        RatingBarItem(
                          star: 2,
                          value: cubit.getPercentage(2),
                        ),
                        RatingBarItem(
                          star: 1,
                          value: cubit.getPercentage(1),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
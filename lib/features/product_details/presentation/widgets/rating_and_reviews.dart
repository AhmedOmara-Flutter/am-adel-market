import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../reviews/presentation/view_model/get_review_cubit/get_review_cubit.dart';

class RatingAndReviews extends StatefulWidget {
  const RatingAndReviews({super.key, required this.product});

  final ProductEntity product;

  @override
  State<RatingAndReviews> createState() => _RatingAndReviewsState();
}

class _RatingAndReviewsState extends State<RatingAndReviews> {
  @override
  void initState() {
    super.initState();

    context.read<GetReviewCubit>().getReviews(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<GetReviewCubit>();

    return Row(
      children: [
        /// ─────────────────────────────
        /// Rating
        /// ─────────────────────────────
        Container(
          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8E8),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 24.w,
                height: 24.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC529),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFC529).withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.star_rounded,
                  color: Colors.white,
                  size: 15.sp,
                ),
              ),

              SizedBox(width: 6.w),

              Text(
                cubit.averageRating.toStringAsFixed(1),
                style: StyleManager.font16Weight700.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 10.w),

        /// ─────────────────────────────
        /// Reviews Count
        /// ─────────────────────────────
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "التقييمات",
              style: StyleManager.font11Weight400.copyWith(
                color: AppColor.textSecondary,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "${cubit.reviews.length} مراجعة",
              style: StyleManager.font13Weight600.copyWith(
                color: AppColor.textPrimary,
              ),
            ),
          ],
        ),

        const Spacer(),

        /// ─────────────────────────────
        /// Reviews CTA
        /// ─────────────────────────────
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10.r),
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteManager.reviews,
                arguments: widget.product.id,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.mainColor.withOpacity(0.25),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "المراجعات",
                    style: StyleManager.font13Weight600.copyWith(
                      color: AppColor.mainColor,
                    ),
                  ),

                  SizedBox(width: 4.w),

                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 11.sp,
                    color: AppColor.mainColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

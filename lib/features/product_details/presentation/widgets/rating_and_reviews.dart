import '../../../../core/entities/product_entity.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../reviews/presentation/view_model/get_review_cubit/get_review_cubit.dart';

class RatingAndReviews extends StatefulWidget {
  const RatingAndReviews({
    super.key,
    required this.product,
  });

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
        Icon(
          Icons.star,
          color: const Color(0xffFFC529),
          size: 18.sp,
        ),

        SizedBox(width: 6.w),

        Text(
          "${cubit.averageRating}",
          style: StyleManager.font16Weight600.copyWith(
            color: AppColor.textPrimary,
          ),
        ),

        SizedBox(width: 6.w),

        Text(
          "(+${cubit.reviews.length})",
          style: StyleManager.font13Weight400,
        ),

        SizedBox(width: 12.w),

        Container(
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: AppColor.textSecondary,
            shape: BoxShape.circle,
          ),
        ),

        SizedBox(width: 12.w),

        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteManager.reviews,
              arguments: widget.product.id,
            );
          },
          child: Text(
            "المراجعات",
            style: StyleManager.font14Weight600.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColor.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
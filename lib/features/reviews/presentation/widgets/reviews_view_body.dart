import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/features/reviews/presentation/widgets/rating_breakdown_section.dart';
import '../../../../core/utils/app_imports.dart';
import '../../domain/entities/review_entity.dart';
import '../view_model/add_review_cubit/add_review_cubit.dart';
import 'review_bar_section.dart';
import 'review_field_section.dart';

class ReviewsViewBody extends StatefulWidget {
  final String productId;

  const ReviewsViewBody({super.key, required this.productId});

  @override
  State<ReviewsViewBody> createState() => _ReviewsViewBodyState();
}

class _ReviewsViewBodyState extends State<ReviewsViewBody> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddReviewCubit, AddReviewState>(
      builder: (context, state) {
        var cubit = context.read<AddReviewCubit>();
        return Form(
          key: formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: InfoActionRow(text: 'المراجعه', showBack: true),
              ),
              CustomReviewFieldSection(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                controller: cubit.reviewController,
              ),
              CustomReviewBarSection(
                initialRate: cubit.rate,
                ratingUpdate: (double p1) {
                  cubit.updateRatingField(p1);
                },
              ),
              SliverToBoxAdapter(
                child: CustomButton(
                  onPressed: state is AddReviewLoading?null: () {
                    final textValid = cubit.reviewController.text
                        .trim()
                        .isNotEmpty;
                    final ratingValid = cubit.rate != 0;

                    if (textValid && ratingValid) {
                      cubit.addReview(
                        ReviewEntity(
                          date: DateTime.now().toString(),
                          reviewDescription: cubit.reviewController.text,
                          rating: cubit.rate,
                          name: getUser().userName,
                        ),
                        widget.productId,
                      );
                      FocusScope.of(context).unfocus();
                    } else {
                      customShowSnakeBar(
                        context,
                        color: Colors.red,
                        label: 'برجاء كتابة تعليق وتقييم المنتج',
                      );
                    }
                  },
                  child: state is AddReviewLoading ? CircularProgressIndicator(
                    color: Colors.white,) : Text(
                    'اضافه تعليق',
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelSmall,
                  ),
                ),
              ),
              RatingBreakdownSection(),
            ],
          ),
        );
      },
    );
  }
}

import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/reviews/presentation/widgets/reviews_view_body.dart';
import '../view_model/add_review_cubit/add_review_cubit.dart';
import '../view_model/get_review_cubit/get_review_cubit.dart';

class ReviewsView extends StatelessWidget {
  final String productId;

  const ReviewsView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AddReviewCubit, AddReviewState>(
        listener: (context, state) {
          if (state is AddReviewError) {
            customShowSnakeBar(
              context,
              color: Colors.red,
              label: state.errMessage,
            );
          }
          if (state is AddReviewSuccess) {
            customShowSnakeBar(
                context,
                color:AppColor.green,
                label:'شكراً ليك! تم إضافة تعليقك بنجاح 👌'
            );
            context.read<AddReviewCubit>().reviewController.clear();
            context.read<AddReviewCubit>().rate=0;


          }
        },
        child: ReviewsViewBody(productId: productId,),
      ),
    );
  }
}


import '../../../../core/utils/app_imports.dart';
import '../view_model/best_selling_cubit.dart';
import 'best_selling_more_view_body.dart';

class BestSellingMoreView extends StatelessWidget {
  const BestSellingMoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<BestSellingCubit>(context),
      child: Scaffold(body: BestSellingMoreViewBody()),
    );
  }
}

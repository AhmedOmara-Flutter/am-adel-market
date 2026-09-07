import '../../../../core/utils/app_imports.dart';
import '../widgets/favorite_view_body.dart';

class FavoriteView extends StatelessWidget {

  const FavoriteView({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FavoriteViewBody(),
    );
  }
}

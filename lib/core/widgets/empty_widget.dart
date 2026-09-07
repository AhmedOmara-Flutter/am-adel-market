import 'package:lottie/lottie.dart';

import '../utils/app_imports.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(Assets.assets.json.empty),
    );
  }
}

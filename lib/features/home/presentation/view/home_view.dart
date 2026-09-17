import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:flutter/services.dart';

import '../../../../core/widgets/falling_flowers.dart';
import '../widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: HomeViewBody(),
    );
  }
}

//import 'package:am_adel_market/core/utils/app_imports.dart';
//
// import '../../../../core/widgets/falling_flowers.dart';
// import '../../../../core/widgets/mawlid_celebration.dart';
// import '../widgets/home_view_body.dart';
//
// class HomeView extends StatefulWidget {
//   const HomeView({super.key,});
//
//   @override
//   State<HomeView> createState() => _HomeViewState();
// }
//
// class _HomeViewState extends State<HomeView> {
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showMawlidCelebrationPopup(context);
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         const HomeViewBody(),
//
//         const Positioned.fill(
//           child: MawlidCelebrationOverlay(),
//         ),
//       ],
//     );  }
// }

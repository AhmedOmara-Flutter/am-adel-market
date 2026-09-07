import 'package:lottie/lottie.dart';
import '../../../../core/utils/app_imports.dart';

class EmptyOrderWidget extends StatelessWidget {
  const EmptyOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 40),
          Lottie.asset(
            Assets.assets.json.empty,
            height: MediaQuery.sizeOf(context).height * 0.30,
            fit: BoxFit.fill
          ),

          const SizedBox(height: 20),

          Text(
            "لا توجد طلبات حتى الآن",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "ابدأ تصفح المنتجات واختر ما يعجبك، وستجد طلباتك هنا",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          CustomButton(
            onPressed: () {
              context.read<MainCubit>().currentIndex=0;
              Navigator.pushNamed(context, RouteManager.home);
            },
            child: Text(
              'ابدأ التسوق',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),

        ],
      ),
    );
  }
}
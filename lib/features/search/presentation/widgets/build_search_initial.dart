import '../../../../core/utils/app_imports.dart';

class BuildSearchInitial extends StatelessWidget {
  const BuildSearchInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 80),
          SvgPicture.asset(Assets.assets.images.searchImage.path, height: 180),
          const SizedBox(height: 20),
          Text(
            "ابحث عن منتجاتك المفضلة",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

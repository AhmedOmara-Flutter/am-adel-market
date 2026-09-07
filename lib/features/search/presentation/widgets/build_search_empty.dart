import '../../../../core/utils/app_imports.dart';

class BuildSearchEmpty extends StatelessWidget {
  final String ?query;
  const BuildSearchEmpty({super.key,  this.query});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 60),
          SvgPicture.asset(
            'assets/images/searchImage.svg',
            height: 180,
          ),
          const SizedBox(height: 20),
          Text(
            "لا توجد نتائج لـ \"${query ?? ''}\"",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          Text(
            "جرب كلمات بحث مختلفة",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

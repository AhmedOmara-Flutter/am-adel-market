
import '../../../../core/utils/app_imports.dart';

class InfoGridCard extends StatelessWidget {
  final String iconImage;
  final String title;
  final String sub;

  const InfoGridCard({
    super.key,
    required this.iconImage,
    required this.title,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(15),
        border: Border.all(color: Color(0xffF1F1F5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColor.mainColor),
                ),
                SizedBox(height: 8),
                Text(
                  sub,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(color: Color(0xff979899)),
                ),
              ],
            ),
          ),
          Center(child: SvgPicture.asset(iconImage)),
        ],
      ),
    );
  }
}

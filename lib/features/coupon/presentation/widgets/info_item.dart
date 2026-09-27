import '../../../../core/utils/app_imports.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 15, color: AppColor.accentColor),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: StyleManager.font11Weight400.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: StyleManager.font14Weight600.copyWith(
            color: AppColor.textPrimary,
          ),
        ),

        const SizedBox(height: 5),

        Container(
          width: 22,
          height: 2,
          decoration: BoxDecoration(
            color: AppColor.accentColor.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}

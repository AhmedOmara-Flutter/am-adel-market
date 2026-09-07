import '../../../../core/utils/app_imports.dart';

class AppInfoBanner extends StatelessWidget {
  const AppInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 8,
        right: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white.withOpacity(0.18),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time_rounded,
            size: 16,
            color: Colors.white.withOpacity(0.55),
          ),
          const SizedBox(width: 6),
          Text(
            'مواعيد الطلب من التطبيق: 5:00 عصراً إلى 3:00 فجراً',
            style: StyleManager.font11Weight400,
          ),
          const SizedBox(width: 6),
          Icon(
            Icons.access_time_rounded,
            size: 16,
            color: Colors.white.withOpacity(0.55),
          ),
        ],
      ),
    );
  }
}
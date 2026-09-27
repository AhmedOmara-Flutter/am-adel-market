import '../../../../core/utils/app_imports.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.text,
    required this.isAvailable,
  });

  final String text;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isAvailable
            ? AppColor.accentColor.withValues(alpha: 0.10)
            : AppColor.textSecondary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAvailable
                  ? AppColor.accentColor
                  : AppColor.textSecondary,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: isAvailable
                  ? AppColor.mainColor
                  : AppColor.textSecondary,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
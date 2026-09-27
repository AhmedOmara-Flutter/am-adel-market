import '../../../../core/utils/app_imports.dart';

class ExpirySection extends StatelessWidget {
  const ExpirySection({
    required this.expiresAt,
    required this.now,
    required this.isUsed,
  });

  final DateTime expiresAt;
  final DateTime now;
  final bool isUsed;

  @override
  Widget build(BuildContext context) {
    final difference = expiresAt.difference(now);
    final expired = difference.isNegative || difference.inSeconds <= 0;

    final Color mainColor = expired || isUsed
        ? AppColor.textSecondary
        : AppColor.mainColor;

    final Color backgroundColor = expired || isUsed
        ? AppColor.textSecondary.withValues(alpha: 0.06)
        : AppColor.accentColor.withValues(alpha: 0.10);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: expired || isUsed
              ? AppColor.textSecondary.withValues(alpha: 0.10)
              : AppColor.accentColor.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: expired || isUsed
                  ? AppColor.textSecondary.withValues(alpha: 0.08)
                  : AppColor.accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(
              expired || isUsed
                  ? Icons.event_busy_outlined
                  : Icons.timer_outlined,
              size: 18,
              color: mainColor,
            ),
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUsed
                      ? 'حالة الكوبون'
                      : expired
                      ? 'صلاحية الكوبون'
                      : 'متبقي على انتهاء الكوبون',
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  isUsed
                      ? 'تم استخدام الكوبون'
                      : expired
                      ? 'انتهت الصلاحية'
                      : _formatRemaining(difference),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font14Weight600.copyWith(
                    color: mainColor,
                  ),
                ),
              ],
            ),
          ),

          if (!expired && !isUsed)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'ينتهي في',
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatExpiryDate(expiresAt),
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  String _formatRemaining(Duration duration) {
    if (duration.inDays > 0) {
      final days = duration.inDays;
      final hours = duration.inHours % 24;

      if (hours > 0) {
        return '$days يوم و $hours ساعة';
      }

      return '$days يوم';
    }

    if (duration.inHours > 0) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes % 60;

      if (minutes > 0) {
        return '$hours ساعة و $minutes دقيقة';
      }

      return '$hours ساعة';
    }

    final minutes = duration.inMinutes;

    if (minutes > 0) {
      return '$minutes دقيقة';
    }

    return 'أقل من دقيقة';
  }

  String _formatExpiryDate(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
        ? date.hour - 12
        : date.hour;

    final minute = date.minute.toString().padLeft(2, '0');

    final period = date.hour >= 12 ? 'م' : 'ص';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} - '
        '$hour:$minute $period';
  }
}

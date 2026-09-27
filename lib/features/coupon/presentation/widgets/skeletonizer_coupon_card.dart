import 'package:am_adel_market/core/utils/app_imports.dart';

class SkeletonizerCouponCard extends StatelessWidget {
  const SkeletonizerCouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: AppColor.cardLight,
        highlightColor: AppColor.backgroundDark,
        duration: const Duration(milliseconds: 1200),
      ),
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColor.cardLight,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: AppColor.accentColor.withValues(alpha: 0.22),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.mainColor.withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.local_offer_rounded,
                    size: 23,
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'SUMMER20',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          Container(
                            width: 52,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 3),

                      Text(
                        'خصم 20٪ على طلبك',
                        style: StyleManager.font12Weight500,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'الحد الأدنى',
                            style: StyleManager.font12Weight500,
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '100 جنيه',
                        style: StyleManager.font12Weight500,
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 1,
                  height: 38,
                  color: AppColor.accentColor.withValues(alpha: 0.15),
                ),

                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.percent_rounded,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'قيمة الخصم',
                            style: StyleManager.font11Weight400,
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        '20%',
                        style: StyleManager.font12Weight500,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            SizedBox(
              width: double.infinity,
              height: 42,
              child: CustomButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.local_offer_outlined,
                      size: 16,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      'استخدم الكوبون',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

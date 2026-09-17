import '../../../../../core/utils/app_imports.dart';

class DeliveryInfoSection extends StatelessWidget {
  final String locationName;
  final double deliveryCost;
  final String fullAddress;
  final VoidCallback? onEdit;

  const DeliveryInfoSection({
    super.key,
    required this.locationName,
    required this.deliveryCost,
    required this.fullAddress,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColor.border.withOpacity(.22)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(.045),
            blurRadius: 22.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(17.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    color: AppColor.textOnDark,
                    size: 22.sp,
                  ),
                ),

                SizedBox(width: 12.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'بيانات التوصيل',
                        style: StyleManager.font16Weight700.copyWith(
                          color: AppColor.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'سيتم توصيل طلبك إلى',
                        style: StyleManager.font11Weight400.copyWith(
                          color: AppColor.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: onEdit,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColor.border.withOpacity(.20),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Assets.assets.images.edit.path,
                          color: AppColor.mainColor,
                          width: 15.w,
                          height: 15.h,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          'تعديل',
                          style: StyleManager.font12Weight500.copyWith(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 18.h),

            // Location
            Container(
              padding: EdgeInsets.all(13.w),
              decoration: BoxDecoration(
                color: AppColor.background.withOpacity(.55),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColor.border.withOpacity(.16)),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(.09),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.location_city_rounded,
                          color: AppColor.mainColor,
                          size: 19.sp,
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المنطقة',
                              style: StyleManager.font11Weight400.copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              locationName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: StyleManager.font13Weight700.copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 9.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.accentColor.withOpacity(.13),
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: Text(
                          '${deliveryCost.toStringAsFixed(0)} ج.م',
                          style: StyleManager.font11Weight400.copyWith(
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 11.h),
                    child: Divider(
                      height: 1,
                      color: AppColor.divider.withOpacity(.45),
                    ),
                  ),

                  // Full Address
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: AppColor.secondaryColor.withOpacity(.09),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(9.w),
                          child: SvgPicture.asset(
                            Assets.assets.images.location.path,
                            color: AppColor.secondaryColor,
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'العنوان بالتفصيل',
                              style: StyleManager.font11Weight400.copyWith(
                                color: AppColor.textSecondary,
                              ),
                            ),
                            SizedBox(height: 3.h),
                            Text(
                              fullAddress,
                              style: StyleManager.font13Weight600.copyWith(
                                color: AppColor.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

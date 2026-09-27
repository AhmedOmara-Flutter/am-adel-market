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
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.border.withOpacity(.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: const Icon(
                  Icons.location_on_outlined,
                  color: AppColor.mainColor,
                  size: 20,
                ),
              ),

              SizedBox(width: 9.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بيانات التوصيل',
                      style: StyleManager.font15Weight700.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'عنوان توصيل الطلب',
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
                  padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(9.r),
                    border: Border.all(color: AppColor.border.withOpacity(.16)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        Assets.assets.images.edit.path,
                        color: AppColor.mainColor,
                        width: 14.w,
                        height: 14.h,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'تعديل',
                        style: StyleManager.font11Weight400.copyWith(
                          color: AppColor.mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(13.r),
              border: Border.all(color: AppColor.border.withOpacity(.12)),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_city_rounded,
                      color: AppColor.mainColor,
                      size: 19.sp,
                    ),
                    SizedBox(width: 9.w),
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
                        horizontal: 8.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.accentColor.withOpacity(.12),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${deliveryCost.toStringAsFixed(0)} ج.م',
                        style: StyleManager.font11Weight400.copyWith(
                          color: AppColor.mainColor,
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Divider(
                    height: 1,
                    color: AppColor.divider.withOpacity(.35),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.home_rounded,
                      color: AppColor.secondaryColor,
                      size: 19.sp,
                    ),
                    SizedBox(width: 9.w),
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
                          SizedBox(height: 2.h),
                          Text(
                            fullAddress,
                            style: StyleManager.font12Weight500.copyWith(
                              color: AppColor.textPrimary,
                              height: 1.4,
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
    );
  }
}

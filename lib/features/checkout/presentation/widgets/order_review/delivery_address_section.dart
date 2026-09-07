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
      padding: EdgeInsets.symmetric(
        vertical: 14.h,
        horizontal: 15.w,
      ),
      decoration: BoxDecoration(
        color: AppColor.card,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColor.border,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'بيانات التوصيل',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.assets.images.edit.path,
                      color: AppColor.textSecondary,
                      width: 18.w,
                      height: 18.h,
                    ),
                    SizedBox(width: 5.w),
                    Text(
                      'تعديل',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// المنطقة
          Row(
            children: [
              Icon(
                Icons.location_city_outlined,
                size: 20.sp,
                color: AppColor.textSecondary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  locationName,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ),
              /// سعر التوصيل
              // Row(
              //   children: [
              //     Icon(
              //       Icons.local_shipping_outlined,
              //       size: 20.sp,
              //       color: AppColor.textSecondary,
              //     ),
              //     SizedBox(width: 8.w),
              //     Text(
              //       '$deliveryCost جنيه',
              //       style: Theme.of(context).textTheme.labelMedium!.copyWith(
              //         color: AppColor.mainColor,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),

          SizedBox(height: 12.h),

          /// العنوان
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                Assets.assets.images.location.path,
                color: AppColor.textSecondary,
                width: 18.w,
                height: 18.h,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  fullAddress,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
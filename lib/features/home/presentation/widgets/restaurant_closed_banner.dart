import '../../../../core/utils/app_imports.dart';
import '../../../restaurant_status/presentation/view_model/restaurant_status_cubit.dart';

class RestaurantClosedBanner extends StatelessWidget {
  const RestaurantClosedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantStatusCubit, RestaurantStatusState>(
      builder: (context, state) {
        if (state is! RestaurantStatusLoaded ||
            state.restaurantStatus.isOpen) {
          return SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
          ),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColor.backgroundDark,
                AppColor.cardLight,
              ],
            ),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: AppColor.border.withOpacity(.45),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.black.withOpacity(.06),
                blurRadius: 15.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Row(
            children: [
// =====================================================
// ICON
// =====================================================
              Container(
                width: 58.w,
                height: 58.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.mainColor.withOpacity(.12),
                  border: Border.all(
                    color: AppColor.mainColor.withOpacity(.18),
                  ),
                ),
                child: Icon(
                  Icons.lock_outline_rounded,
                  color: AppColor.mainColor,
                  size: 28.sp,
                ),
              ),

              SizedBox(width: 14.w),

// =====================================================
// TEXT
// =====================================================
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            'المطعم مغلق حاليًا',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.font15Weight800.copyWith(
                              color: AppColor.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(width: 25.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 7.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.red.withOpacity(.09),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.red,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'مغلق',
                                style: StyleManager.font13Weight600.copyWith(
                                  color: AppColor.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    Text(
                      'لا يمكن استقبال الطلبات في الوقت الحالي',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary,
                        height: 1.4,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 14.sp,
                          color: AppColor.mainColor,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'ننتظركم قريبًا ❤️',
                          style: StyleManager.font13Weight600.copyWith(
                            color: AppColor.mainColor,
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
      },
    );
  }
}

import 'package:am_adel_market/core/widgets/resto_kit.dart';
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
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: RestoFrame(
            radius: 24,
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                // ===== أيقونة المحل + القفل =====
                SizedBox(
                  width: 66.w,
                  height: 66.w,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: Container(
                          padding: EdgeInsets.all(2.5.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: Resto.gold,
                            boxShadow: Resto.shadow(alpha: .14, blur: 10, dy: 4),
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.white,
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.storefront_rounded,
                              size: 30.sp,
                              color: AppColor.mainColor,
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: -2.h,
                        end: -2.w,
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.red,
                            border: Border.all(color: AppColor.white, width: 2),
                          ),
                          child: Icon(
                            Icons.lock_rounded,
                            size: 12.sp,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 14.w),

                // ===== النص =====
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
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
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.red.withValues(alpha: .10),
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: AppColor.red.withValues(alpha: .30),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6.w,
                                  height: 6.w,
                                  decoration: const BoxDecoration(
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

                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: SizedBox(
                          width: 84.w,
                          child: const RestoDivider(compact: true),
                        ),
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

                      SizedBox(height: 6.h),

                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 14.sp,
                            color: AppColor.secondaryColor,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'ننتظركم قريبًا ❤️',
                            style: StyleManager.font13Weight600.copyWith(
                              color: AppColor.secondaryColor,
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
      },
    );
  }
}
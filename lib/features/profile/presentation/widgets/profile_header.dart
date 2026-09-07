import 'dart:io';
import 'package:am_adel_market/core/helper_function/make_full_name.dart';
import '../../../../core/helper_function/get_user.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../restaurant_status/presentation/view_model/restaurant_status_cubit.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  File? imagePath;

  @override
  Widget build(BuildContext context) {
    final user = getUser();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.border, width: 2.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.35),
                      blurRadius: 15.r,
                      offset: Offset(0, 6.h),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    Assets.assets.images.customer.path,
                    width: 82.w,
                    height: 82.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      makeFullName(user.userName),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColor.textPrimary,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.card,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: AppColor.border),
                      ),
                      child: Text(
                        user.email,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.textSecondary,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          BlocBuilder<RestaurantStatusCubit, RestaurantStatusState>(
            builder: (context, state) {
              if (state is RestaurantStatusLoaded &&
                  !state.restaurantStatus.isOpen) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(.10),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: Colors.red.withOpacity(.20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: Colors.red,
                        size: 13.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'مغلق',
                        style: StyleManager.font13Weight600.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

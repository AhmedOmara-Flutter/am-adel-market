import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/entities/order_entity.dart';
import '../../../../core/utils/app_imports.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';

class PaymentSuccessView extends StatelessWidget {
  final OrderEntity orderEntity;

  const PaymentSuccessView({
    super.key,
    required this.orderEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            InfoActionRow(
              text: 'الدفع',
            ),

            SizedBox(height: 35.h),

            Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                color: AppColor.cardLight,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColor.mainColor.withOpacity(.08),
                    blurRadius: 25.r,
                    offset: Offset(0, 10.h),
                  ),
                ],
              ),
              child: Center(
                child: Lottie.asset(
                  Assets.assets.json.done.path,
                  width: 125.w,
                  height: 125.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: 28.h),

            Text(
              'تم بنجاح!',
              style: StyleManager.font28Weight700.copyWith(
                color: AppColor.mainColor,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'تم استلام طلبك بنجاح',
              textAlign: TextAlign.center,
              style: StyleManager.font13Weight400.copyWith(
                color: AppColor.textSecondary,
              ),
            ),

            SizedBox(height: 20.h),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 18.w,
                vertical: 15.h,
              ),
              decoration: BoxDecoration(
                color: AppColor.cardLight,
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(
                  color: AppColor.border.withOpacity(.22),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor.withOpacity(.08),
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Icon(
                      Icons.receipt_long_rounded,
                      color: AppColor.mainColor,
                      size: 21.sp,
                    ),
                  ),

                  SizedBox(width: 12.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'رقم الطلب',
                          style: StyleManager.font11Weight400.copyWith(
                            color: AppColor.textSecondary,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          '#${orderEntity.id}',
                          style: StyleManager.font16Weight700.copyWith(
                            color: AppColor.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.green.withOpacity(.10),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: AppColor.green,
                          size: 15.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'مؤكد',
                          style: StyleManager.font11Weight400.copyWith(
                            color: AppColor.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            CustomButton(
              onPressed: () {
                context
                    .read<CartCubit>()
                    .cart
                    .cartItems
                    .clear();
                context.read<CartCubit>().saveCart(getUser().uId);
                context
                    .read<MainCubit>()
                    .currentIndex = 0;

                Navigator.pushNamed(
                  context,
                  RouteManager.home,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'الرئيسية',
                    style: StyleManager.font15Weight800.copyWith(
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.home_rounded,
                    color: AppColor.white,
                    size: 19.sp,
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

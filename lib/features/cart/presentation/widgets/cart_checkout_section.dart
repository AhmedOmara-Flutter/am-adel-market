import '../../../../core/utils/app_imports.dart';
import '../../../restaurant_status/presentation/view_model/restaurant_status_cubit.dart';
import '../view_model/cart_cubit.dart';

class CartCheckoutSection extends StatelessWidget {
  final num totalPrice;

  const CartCheckoutSection({
    super.key,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();

    return SliverToBoxAdapter(
      child: BlocSelector<RestaurantStatusCubit, RestaurantStatusState, bool>(
        selector: (state) {
          if (state is RestaurantStatusLoaded) {
            return state.restaurantStatus.isOpen;
          }

          return false;
        },
        builder: (context, isRestaurantOpen) {
          return Padding(
            padding: EdgeInsets.only(
              top: 30.h,
              left: 16.w,
              right: 16.w,
              bottom: 20.h,
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isRestaurantOpen
                  ? CustomButton(
                key: const ValueKey('checkout'),
                child: Text(
                  'الدفع ${totalPrice.toStringAsFixed(2)} جنيه',
                  style:StyleManager.font15Weight800.copyWith(color: AppColor.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteManager.checkout,
                    arguments: cubit.cart,
                  );
                },
              )
                  : RestaurantClosedBanner(),
            ),
          );
        },
      ),
    );
  }
}

class RestaurantClosedBanner extends StatelessWidget {
  const RestaurantClosedBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const ValueKey('closed'),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 15.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.45),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.08),
            blurRadius: 12.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: AppColor.red.withOpacity(.10),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '🏪',
              style: TextStyle(
                fontSize: 23.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المطعم مغلق حاليًا',
                  style: StyleManager.font14Weight600.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'لا يمكن إتمام الطلب الآن، حاول مرة أخرى لاحقًا',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
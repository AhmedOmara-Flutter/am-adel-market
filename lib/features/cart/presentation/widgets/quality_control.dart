import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/utils/app_imports.dart';
import '../view_model/cart_cubit.dart';

class QualityControl extends StatelessWidget {
  final CartItemEntity cartItemEntity;

  const QualityControl({
    super.key,
    required this.cartItemEntity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColor.card,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: AppColor.border,
              width: 1.w,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildButton(
                icon: Icons.add_rounded,
                background: AppColor.mainColor,
                iconColor: Colors.white,
                onTap: () {
                  cubit.increaseCartItem(
                    cartItemEntity,
                    getUser().uId,
                  );
                },
              ),

              SizedBox(width: 14.w),

              SizedBox(
                width: 28.w,
                child: Text(
                  '${cartItemEntity.quantity}',
                  textAlign: TextAlign.center,
                  style: StyleManager.font16Weight700.copyWith(
                    color: AppColor.textPrimary,
                  ),
                ),
              ),

              SizedBox(width: 14.w),

              _buildButton(
                icon: Icons.remove_rounded,
                background: Colors.grey.shade100,
                iconColor: AppColor.black,
                onTap: () {
                  cubit.decreaseCartItem(
                    cartItemEntity,
                    getUser().uId,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButton({
    required IconData icon,
    required Color background,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: onTap,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 18.sp,
        ),
      ),
    );
  }
}
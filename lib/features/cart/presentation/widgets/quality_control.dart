import 'package:am_adel_market/core/helper_function/get_user.dart';
import 'package:am_adel_market/features/cart/domain/entities/cart_item_entity.dart';

import '../../../../core/utils/app_imports.dart';
import '../view_model/cart_cubit.dart';

/// كنترول الكمية بطابع ذهبي فخم.
/// [dark] = true للاستخدام فوق الكروت الداكنة (كبسولة زجاجية بحد ذهبي).
class QualityControl extends StatelessWidget {
  final CartItemEntity cartItemEntity;
  final bool dark;

  const QualityControl({
    super.key,
    required this.cartItemEntity,
    this.dark = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final cubit = context.read<CartCubit>();
        final int quantity = cartItemEntity.quantity;

        return Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            gradient: dark
                ? LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.white.withValues(alpha: .12),
                AppColor.white.withValues(alpha: .04),
              ],
            )
                : const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.white, AppColor.cardLight],
            ),
            border: Border.all(
              color: AppColor.accentColor.withValues(alpha: dark ? .6 : .55),
              width: 1,
            ),
            boxShadow: dark
                ? null
                : [
              BoxShadow(
                color: AppColor.mainColor.withValues(alpha: .08),
                blurRadius: 10.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // (+) ذهبي بارز
              _StepButton(
                icon: Icons.add_rounded,
                filled: true,
                dark: dark,
                onTap: () {
                  cubit.increaseCartItem(cartItemEntity, getUser().uId);
                },
              ),

              // الكمية
              SizedBox(
                width: 34.w,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  transitionBuilder: (child, animation) => ScaleTransition(
                    scale: animation,
                    child: FadeTransition(opacity: animation, child: child),
                  ),
                  child: Text(
                    '$quantity',
                    key: ValueKey<int>(quantity),
                    textAlign: TextAlign.center,
                    style: StyleManager.font16Weight700.copyWith(
                      color: dark ? AppColor.white : AppColor.mainColor,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),

              // (−)
              _StepButton(
                icon: Icons.remove_rounded,
                filled: false,
                dark: dark,
                onTap: () {
                  cubit.decreaseCartItem(cartItemEntity, getUser().uId);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// زرار دايري بتأثير ضغطة (بيصغر شوية)
class _StepButton extends StatefulWidget {
  final IconData icon;
  final bool filled;
  final bool dark;
  final VoidCallback onTap;

  const _StepButton({
    required this.icon,
    required this.filled,
    required this.dark,
    required this.onTap,
  });

  @override
  State<_StepButton> createState() => _StepButtonState();
}

class _StepButtonState extends State<_StepButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final bool filled = widget.filled;
    final bool dark = widget.dark;

    final Color? plainColor = filled
        ? null
        : (dark ? AppColor.white.withValues(alpha: .08) : AppColor.white);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? .88 : 1,
        duration: const Duration(milliseconds: 110),
        curve: Curves.easeOut,
        child: Container(
          width: 32.r,
          height: 32.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: plainColor,
            gradient: filled
                ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColor.goldLight, AppColor.accentColor],
            )
                : null,
            border: Border.all(
              color: filled
                  ? (dark ? AppColor.goldLight : AppColor.white)
                  : AppColor.accentColor.withValues(alpha: .6),
              width: filled ? 1.6 : 1.2,
            ),
            boxShadow: filled
                ? [
              BoxShadow(
                color: AppColor.accentColor.withValues(alpha: .45),
                blurRadius: 8.r,
                offset: Offset(0, 3.h),
              ),
            ]
                : null,
          ),
          child: Icon(
            widget.icon,
            color: (!filled && dark) ? AppColor.goldLight : AppColor.mainColor,
            size: 18.sp,
          ),
        ),
      ),
    );
  }
}
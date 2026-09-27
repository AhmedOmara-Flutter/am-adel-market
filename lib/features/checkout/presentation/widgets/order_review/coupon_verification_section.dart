import '../../../../../core/utils/app_imports.dart';
import '../../view_model/checkout_cubit.dart';

class CouponVerificationSection extends StatefulWidget {
  const CouponVerificationSection({
    super.key,
    this.initialCode,
    this.discountText,
    this.isValid = false,
    required this.onVerify,
    required this.onRemove,
  });

  final String? initialCode;
  final String? discountText;
  final bool isValid;

  final ValueChanged<String> onVerify;
  final VoidCallback onRemove;

  @override
  State<CouponVerificationSection> createState() =>
      _CouponVerificationSectionState();
}

class _CouponVerificationSectionState extends State<CouponVerificationSection> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final code = widget.initialCode ?? '';

    _controller = TextEditingController(text: code);

    context.read<CheckoutCubit>().enteredCouponCode = code.trim();
  }

  @override
  void didUpdateWidget(covariant CouponVerificationSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialCode != widget.initialCode) {
      final code = widget.initialCode ?? '';

      _controller.text = code;

      context.read<CheckoutCubit>().enteredCouponCode = code.trim();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isValid) {
      return _buildAppliedCoupon();
    }

    return Container(
      margin: EdgeInsets.only(top: 10.h),
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.accentColor.withValues(alpha: 0.18)),
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
                  Icons.local_offer_outlined,
                  color: AppColor.mainColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'لديك كوبون خصم؟',
                      style: StyleManager.font15Weight700.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'أدخل الكود للحصول على الخصم',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),

          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColor.accentColor.withValues(alpha: 0.12),
                    ),
                  ),
                  child: TextField(
                    controller: _controller,
                    textDirection: TextDirection.ltr,
                    textCapitalization: TextCapitalization.characters,
                    style: StyleManager.font14Weight600.copyWith(
                      color: AppColor.textPrimary,
                      letterSpacing: 1,
                    ),
                    onChanged: (value) {
                      context.read<CheckoutCubit>().enteredCouponCode = value
                          .trim();
                    },
                    decoration: InputDecoration(
                      hintText: 'أدخل كود الخصم',
                      hintStyle: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 12,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              BlocBuilder<CheckoutCubit, CheckoutState>(
                builder: (context, state) {
                  final isLoading = state is CheckoutCouponLoading;

                  return GestureDetector(
                    onTap: isLoading
                        ? null
                        : () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            widget.onVerify(_controller.text.trim());
                          },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 76,
                      height: 46,
                      decoration: BoxDecoration(
                        color: isLoading
                            ? AppColor.mainColor.withValues(alpha: 0.65)
                            : AppColor.mainColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: isLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.check_rounded,
                                    size: 17,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'تحقق',
                                    style: StyleManager.font12Weight500
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAppliedCoupon() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColor.accentColor.withValues(alpha: 0.22)),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Icon(
                    Icons.local_offer_rounded,
                    color: AppColor.mainColor,
                    size: 22,
                  ),
                ),

                const SizedBox(width: 11),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'كوبون الخصم',
                            style: StyleManager.font13Weight700.copyWith(
                              color: AppColor.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.green.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(
                              'مطبق',
                              style: StyleManager.font11Weight400.copyWith(
                                color: AppColor.green,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Text(
                        widget.initialCode ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.font11Weight400.copyWith(
                          color: AppColor.textSecondary,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed: () {
                    _controller.clear();
                    widget.onRemove();
                  },
                  splashRadius: 20,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 34,
                    minHeight: 34,
                  ),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 19,
                    color: AppColor.textSecondary.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            height: 1,
            color: AppColor.border.withValues(alpha: 0.18),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(14, 11, 14, 13),
            child: Row(
              children: [
                Icon(
                  Icons.savings_outlined,
                  size: 17,
                  color: AppColor.accentColor,
                ),

                const SizedBox(width: 7),

                Text(
                  'قيمة الخصم',
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),

                const Spacer(),

                Text(
                  '-${widget.discountText ?? ''}',
                  style: StyleManager.font15Weight800.copyWith(
                    color: AppColor.mainColor,
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

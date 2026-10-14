import '../../../../core/enums/order_enum.dart';
import '../../../../core/utils/app_imports.dart';
import '../../data/models/step_model.dart';

class OrderTimeline extends StatefulWidget {
  final OrderStatus status;

  const OrderTimeline({
    super.key,
    required this.status,
  });

  @override
  State<OrderTimeline> createState() => _OrderTimelineState();
}

class _OrderTimelineState extends State<OrderTimeline>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int get currentStep {
    switch (widget.status) {
      case OrderStatus.pending:
        return 0;
      case OrderStatus.confirmed:
        return 1;
      case OrderStatus.delivered:
      case OrderStatus.paid:
        return 2;
      case OrderStatus.cancelled:
        return -1;
    }
  }

  bool get isCancelled => widget.status == OrderStatus.cancelled;

  bool get isDelivered =>
      widget.status == OrderStatus.delivered ||
          widget.status == OrderStatus.paid;

  final List<StepModel> steps = [
    StepModel(
      "تم استلام الطلب",
      "جاري مراجعة الطلب",
      Icons.shopping_bag_outlined,
    ),
    StepModel(
      "تم قبول الطلب",
      "بدأ تجهيز الطلب",
      Icons.check_circle_outline,
    ),
    StepModel(
      "تم الانتهاء",
      "انتهاء تجهيز الطلب",
      Icons.local_shipping_outlined,
    ),
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.22),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainColor.withOpacity(.04),
            blurRadius: 16.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 22.h),

          ...List.generate(steps.length, (index) {
            final isDone = !isCancelled &&
                (currentStep > index ||
                    (isDelivered && index == steps.length - 1));

            final isActive = !isCancelled &&
                !isDelivered &&
                currentStep == index;

            final isLast = index == steps.length - 1;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        final pulse = isActive
                            ? 1 + (_controller.value * .025)
                            : 1.0;

                        return Transform.scale(
                          scale: pulse,
                          child: Container(
                            width: 54.w,
                            height: 54.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCancelled
                                  ? AppColor.red.withOpacity(.07)
                                  : isDone
                                  ? AppColor.green.withOpacity(.10)
                                  : isActive
                                  ? AppColor.accentColor
                                  .withOpacity(.15)
                                  : AppColor.background
                                  .withOpacity(.65),
                              border: Border.all(
                                color: isCancelled
                                    ? AppColor.red.withOpacity(.30)
                                    : isDone
                                    ? AppColor.green.withOpacity(.45)
                                    : isActive
                                    ? AppColor.accentColor
                                    : AppColor.border
                                    .withOpacity(.25),
                                width: isActive ? 1.6 : 1,
                              ),
                              boxShadow: isActive
                                  ? [
                                BoxShadow(
                                  color: AppColor.accentColor
                                      .withOpacity(
                                    .10 + (_controller.value * .04),
                                  ),
                                  blurRadius: 12.r,
                                  spreadRadius: 1.r,
                                ),
                              ]
                                  : [],
                            ),
                            child: Center(
                              child: Icon(
                                isDone
                                    ? Icons.check_rounded
                                    : isCancelled
                                    ? Icons.close_rounded
                                    : steps[index].icon,
                                size: 25.sp,
                                color: isCancelled
                                    ? AppColor.red
                                    : isDone
                                    ? AppColor.green
                                    : isActive
                                    ? AppColor.mainColor
                                    : AppColor.textSecondary
                                    .withOpacity(.65),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    if (!isLast)
                      Container(
                        width: 2.5.w,
                        height: 72.h,
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: isCancelled
                              ? AppColor.border.withOpacity(.20)
                              : isDone
                              ? AppColor.green.withOpacity(.55)
                              : AppColor.divider.withOpacity(.55),
                        ),
                      ),
                  ],
                ),

                SizedBox(width: 13.w),

                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.only(bottom: 18.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 13.w,
                      vertical: 13.h,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColor.background.withOpacity(.55)
                          : AppColor.white,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: isCancelled
                            ? AppColor.red.withOpacity(.12)
                            : isActive
                            ? AppColor.accentColor.withOpacity(.45)
                            : isDone
                            ? AppColor.green.withOpacity(.18)
                            : AppColor.border.withOpacity(.13),
                        width: isActive ? 1.2 : 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          steps[index].title,
                          style:StyleManager.font12Weight500.copyWith(
                            color: isCancelled
                                ? AppColor.red
                                : isActive || isDone
                                ? AppColor.mainColor
                                : AppColor.textPrimary
                                .withOpacity(.65),
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        SizedBox(height: 9.h),

                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: isCancelled
                                ? AppColor.red.withOpacity(.07)
                                : isDone
                                ? AppColor.green.withOpacity(.08)
                                : isActive
                                ? AppColor.accentColor
                                .withOpacity(.12)
                                : AppColor.background
                                .withOpacity(.45),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            isCancelled
                                ? 'تم إلغاء الطلب'
                                : isDone && index == steps.length - 1
                                ? 'اكتمل بنجاح'
                                : steps[index].subtitle,
                            style:StyleManager.font12Weight500.copyWith(
                              color: isCancelled
                                  ? AppColor.red
                                  : isDone
                                  ? AppColor.green
                                  : isActive
                                  ? AppColor.secondaryColor
                                  : AppColor.textSecondary
                                  .withOpacity(.80),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        if (isActive) ...[
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: const BoxDecoration(
                                  color: AppColor.accentColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Expanded(
                                child: Text(
                                  'طلبك في المرحلة الحالية',
                                  style: StyleManager.font12Weight500.copyWith(
                                    color: AppColor.textSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        if (isDelivered &&
                            index == steps.length - 1) ...[
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.green.withOpacity(.08),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColor.green,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Flexible(
                                  child: Text(
                                    'تم انتهاء الطلب بنجاح',
                                    style: StyleManager.font12Weight500.copyWith(
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final Color statusColor = isCancelled
        ? AppColor.red
        : isDelivered
        ? AppColor.green
        : AppColor.mainColor;

    final IconData statusIcon = isCancelled
        ? Icons.cancel_outlined
        : isDelivered
        ? Icons.check_circle_outline_rounded
        : Icons.receipt_long_outlined;

    final String statusText = isCancelled
        ? 'تم إلغاء الطلب'
        : isDelivered
        ? 'اكتمل الطلب'
        : widget.status == OrderStatus.confirmed
        ? 'جاري تجهيز طلبك'
        : 'متابعة حالة الطلب';

    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: statusColor.withOpacity(.09),
            borderRadius: BorderRadius.circular(13.r),
          ),
          child: Icon(
            statusIcon,
            color: statusColor,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 11.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'حالة الطلب',
                style: StyleManager.font14Weight600.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                statusText,
                style: StyleManager.font11Weight400.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: statusColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}

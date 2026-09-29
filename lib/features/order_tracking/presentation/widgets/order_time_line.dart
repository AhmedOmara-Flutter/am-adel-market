import '../../../../core/enums/order_enum.dart';
import '../../../../core/utils/app_imports.dart';
import '../../data/models/step_model.dart';

class OrderTimeline extends StatefulWidget {
  final OrderStatus status;

  const OrderTimeline({super.key, required this.status});

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

  final List<StepModel> steps = [
    StepModel(
      "تم استلام الطلب",
      "جاري مراجعة الطلب",
      Icons.shopping_bag_outlined,
    ),
    StepModel("تم قبول الطلب", "بدأ تجهيز الطلب", Icons.check_circle_outline),
    StepModel(
      "تم الانتهاء",
      "انتهاء تجهيز الطلب",
      Icons.local_shipping_outlined,
    ),
  ];

  bool get isCancelled => widget.status == OrderStatus.cancelled;

  bool get isDelivered =>
      widget.status == OrderStatus.delivered ||
          widget.status == OrderStatus.paid;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: AppColor.border.withOpacity(.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(.06),
            blurRadius: 12.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        children: List.generate(steps.length, (index) {
          final isDone = currentStep > index;
          final isActive = currentStep == index;
          final isLast = index == steps.length - 1;
          final isPending = !isDone && !isActive;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final pulse = (isActive && !isDelivered)
                          ? 1 + (_controller.value * .08)
                          : 1.0;
                      return Transform.scale(
                        scale: pulse,
                        child: Container(
                          width: 65.w,
                          height: 65.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPending
                                ? AppColor.background
                                : isDone
                                ? AppColor.accentColor.withOpacity(.15)
                                : AppColor.mainColor.withOpacity(.12),
                            border: Border.all(
                              width: 2,
                              color: isPending
                                  ? AppColor.border
                                  : isDone
                                  ? AppColor.accentColor
                                  : AppColor.mainColor,
                            ),
                          ),
                          child: Center(
                            child: Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isPending
                                    ? AppColor.backgroundDark
                                    : isDone
                                    ? AppColor.accentColor
                                    : AppColor.mainColor,
                              ),
                              child: Icon(
                                steps[index].icon,
                                size: 26.sp,
                                color: isPending
                                    ? AppColor.textSecondary
                                    : AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  if (!isLast)
                    Container(
                      width: 2.5.w,
                      height: 70.h,
                      margin: EdgeInsets.symmetric(vertical: 6.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: isDone ? AppColor.accentColor : AppColor.divider,
                      ),
                    ),
                ],
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  margin: EdgeInsets.only(bottom: 18.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isActive ? AppColor.background : AppColor.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color:AppColor.border.withOpacity(.3),
                      width: isActive ? 1.3 : 1,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColor.mainColor.withOpacity(.10),
                              blurRadius: 14.r,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        steps[index].title,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: isCancelled
                              ? AppColor.red
                              : isDone
                              ? AppColor.mainColor
                              : isActive
                              ? AppColor.mainColor
                              : AppColor.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      SizedBox(height: 6.h),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: isActive
                              ? AppColor.accentColor.withOpacity(.15)
                              : isDone
                              ? AppColor.green.withOpacity(.10)
                              : AppColor.background,
                          border: Border.all(
                            color: isActive
                                ? AppColor.accentColor.withOpacity(.45)
                                : isDone
                                ? AppColor.green.withOpacity(.30)
                                : AppColor.divider,
                          ),
                        ),
                        child: Text(
                          steps[index].subtitle,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: isActive
                                    ? AppColor.mainColor
                                    : isDone
                                    ? AppColor.green
                                    : AppColor.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),

                      if (isDelivered && index == steps.length - 1) ...[
                        SizedBox(height: 12.h),

                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: AppColor.green.withOpacity(.10),
                            border: Border.all(
                              color: AppColor.green.withOpacity(.35),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColor.green,
                                size: 16.sp,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                "تم انتهاء الطلب بنجاح",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w700,
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
      ),
    );
  }
}

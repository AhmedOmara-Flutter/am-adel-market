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

  bool get isDelivered => widget.status == OrderStatus.delivered;

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
        color: AppColor.card,
        borderRadius: BorderRadius.circular(18.r),
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
                          ? 1 + (_controller.value * .1)
                          : 1.0;

                      return Transform.scale(
                        scale: pulse,
                        child: Container(
                          width: 65.w,
                          height: 65.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isPending
                                ? null
                                : LinearGradient(
                                    colors: isDone
                                        ? [
                                            AppColor.mainColor.withOpacity(.22),
                                            AppColor.mainColor.withOpacity(.14),
                                          ]
                                        : isActive
                                        ? [
                                            AppColor.mainColor.withOpacity(.18),
                                            AppColor.mainColor.withOpacity(.10),
                                          ]
                                        : [AppColor.card, AppColor.background],
                                  ),
                          ),
                          child: Center(
                            child: Container(
                              width: 65.w,
                              height: 65.w,
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isPending
                                    ? AppColor.border
                                    : AppColor.mainColor.withOpacity(.12),
                              ),
                              child: Icon(
                                steps[index].icon,
                                size: 28.sp,
                                color: isPending
                                    ? AppColor.textSecondary
                                    : AppColor.mainColor,
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
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isDone
                              ? [
                                  AppColor.mainColor,
                                  AppColor.mainColor.withOpacity(.35),
                                ]
                              : [
                                  AppColor.border,
                                  AppColor.border.withOpacity(.5),
                                ],
                        ),
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
                    color: isActive
                        ? AppColor.mainColor.withOpacity(.08)
                        : AppColor.card,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isActive
                          ? AppColor.mainColor.withOpacity(.30)
                          : AppColor.border,
                    ),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: AppColor.mainColor.withOpacity(.12),
                              blurRadius: 16.r,
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
                              : (isDone || isActive)
                              ? AppColor.mainColor
                              : AppColor.textSecondary,
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
                              ? AppColor.mainColor.withOpacity(.12)
                              : AppColor.border,
                          border: Border.all(
                            color: isActive
                                ? AppColor.mainColor.withOpacity(.20)
                                : AppColor.border,
                          ),
                        ),
                        child: Text(
                          steps[index].subtitle,
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: isActive
                                    ? AppColor.mainColor
                                    : AppColor.textSecondary,
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
                            color: AppColor.mainColor.withOpacity(.12),
                            border: Border.all(
                              color: AppColor.mainColor.withOpacity(.25),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColor.mainColor,
                                size: 16.sp,
                              ),

                              SizedBox(width: 6.w),

                              Text(
                                "تم انتهاء الطلب بنجاح",
                                style: Theme.of(context).textTheme.titleSmall!
                                    .copyWith(color: AppColor.mainColor),
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

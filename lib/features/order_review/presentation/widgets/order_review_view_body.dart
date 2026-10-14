import '../../../../core/entities/order_entity.dart';
import '../../../../core/utils/app_imports.dart';
import '../view_model/order_review_cubit.dart';

class OrderReviewViewBody extends StatefulWidget {
  final OrderEntity orderEntity;

  const OrderReviewViewBody({super.key, required this.orderEntity});

  @override
  State<OrderReviewViewBody> createState() => _OrderReviewViewBodyState();
}

class _OrderReviewViewBodyState extends State<OrderReviewViewBody> {
  int foodRating = 0;
  int driverRating = 0;

  final TextEditingController foodController = TextEditingController();

  final TextEditingController driverController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final orderId = widget.orderEntity.id;

      if (orderId != null && orderId.isNotEmpty) {
        context.read<OrderReviewCubit>().checkIfReviewed(orderId);
      }
    });
  }

  @override
  void dispose() {
    foodController.dispose();
    driverController.dispose();
    super.dispose();
  }

  bool get canSubmit {
    return foodRating > 0 && driverRating > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderReviewCubit, OrderReviewState>(
      listener: (context, state) {
        if (state is OrderReviewSuccess) {
          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'تم إرسال تقييمك بنجاح ❤️',
          );
          Navigator.pop(context, true);
        } else if (state is OrderReviewAlreadySubmitted) {
          customShowSnakeBar(
            context,
            color: AppColor.green,
            label: 'لقد قمت بتقييم هذا الطلب من قبل',
          );
        } else if (state is OrderReviewError) {
          customShowSnakeBar(
            context,
            color: AppColor.red,
            label: state.message,
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoActionRow(text: 'تقييم الطلب', showBack: true),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  _buildOrderInfo(context),
                  SizedBox(height: 20.h),

                  _buildSection(
                    context,
                    icon: Icons.restaurant_outlined,
                    title: 'جودة الطعام',
                    hint: 'اكتب رأيك في جودة وطعم الأكل...',
                    rating: foodRating,
                    controller: foodController,
                    onRatingChanged: (value) {
                      setState(() {
                        foodRating = value;
                      });
                    },
                  ),

                  SizedBox(height: 14.h),

                  _buildSection(
                    context,
                    icon: Icons.delivery_dining_outlined,
                    title: 'المندوب',
                    hint: 'اكتب رأيك عن تعامل المندوب...',
                    rating: driverRating,
                    controller: driverController,
                    onRatingChanged: (value) {
                      setState(() {
                        driverRating = value;
                      });
                    },
                  ),

                  SizedBox(height: 24.h),

                  _buildSubmitButton(context),

                  SizedBox(height: 12.h),

                  Center(
                    child: Text(
                      'رأيك يساعدنا على تحسين تجربتك',
                      style: StyleManager.font11Weight400.copyWith(
                        color: AppColor.textSecondary.withOpacity(.65),
                      ),
                    ),
                  ),

                  SizedBox(height: 25.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfo(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColor.border.withOpacity(.22)),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColor.mainColor.withOpacity(.07),
              borderRadius: BorderRadius.circular(11.r),
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 21.sp,
              color: AppColor.mainColor,
            ),
          ),

          SizedBox(width: 11.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'طلب #${widget.orderEntity.id ?? ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.font13Weight400.copyWith(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  'تم الانتهاء من الطلب',
                  style: StyleManager.font11Weight400.copyWith(
                    color: AppColor.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: AppColor.green.withOpacity(.08),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'مكتمل',
              style: StyleManager.font11Weight400.copyWith(
                color: AppColor.green,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String hint,
    required int rating,
    required TextEditingController controller,
    required ValueChanged<int> onRatingChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: AppColor.cardLight,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: AppColor.border.withOpacity(.22)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: AppColor.mainColor.withOpacity(.07),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 19.sp, color: AppColor.mainColor),
              ),

              SizedBox(width: 10.w),

              Text(
                title,
                style: StyleManager.font14Weight600.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                final selected = index < rating;

                return GestureDetector(
                  onTap: () {
                    onRatingChanged(index + 1);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      selected
                          ? Icons.star_rounded
                          : Icons.star_outline_rounded,
                      size: 32.sp,
                      color: AppColor.accentColor,
                    ),
                  ),
                );
              }),
            ),
          ),

          if (rating > 0) ...[
            SizedBox(height: 4.h),
            Center(
              child: Text(
                _ratingText(rating),
                style: StyleManager.font12Weight500.copyWith(
                  color: AppColor.mainColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],

          SizedBox(height: 14.h),

          Container(
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(11.r),
              border: Border.all(color: AppColor.border.withOpacity(.20)),
            ),
            child: TextField(
              controller: controller,
              minLines: 3,
              maxLines: 5,
              textDirection: TextDirection.rtl,
              style: StyleManager.font13Weight400.copyWith(
                color: AppColor.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: StyleManager.font12Weight500.copyWith(
                  color: AppColor.textSecondary.withOpacity(.55),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(13.w),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return BlocBuilder<OrderReviewCubit, OrderReviewState>(
      builder: (context, state) {
        final isLoading = state is OrderReviewLoading;
        final alreadySubmitted = state is OrderReviewAlreadySubmitted;

        final enabled = canSubmit && !isLoading && !alreadySubmitted;

        return GestureDetector(
          onTap: enabled
              ? () {
                  final orderId = widget.orderEntity.id;

                  if (orderId == null || orderId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('رقم الطلب غير صالح')),
                    );
                    return;
                  }

                  context.read<OrderReviewCubit>().submitReview(
                    orderId: orderId,
                    foodRating: foodRating,
                    foodReview: foodController.text,
                    driverRating: driverRating,
                    driverReview: driverController.text,
                  );
                }
              : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: enabled
                  ? AppColor.mainColor
                  : AppColor.mainColor.withOpacity(.25),
              borderRadius: BorderRadius.circular(13.r),
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      alreadySubmitted ? 'تم تقييم هذا الطلب' : 'إرسال التقييم',
                      style: StyleManager.font14Weight600.copyWith(
                        color: AppColor.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }

  String _ratingText(int rating) {
    switch (rating) {
      case 1:
        return 'سيئ جدًا';
      case 2:
        return 'سيئ';
      case 3:
        return 'جيد';
      case 4:
        return 'جيد جدًا';
      case 5:
        return 'ممتاز';
      default:
        return '';
    }
  }
}

import '../../../../core/utils/app_imports.dart';

class OrderItemImage extends StatelessWidget {
  const OrderItemImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72.w,
      height: 72.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.mainColor.withOpacity(.12),
      ),
      child: SvgPicture.asset(
        Assets.assets.images.package.path,
        width: 30.w,
        height: 30.w,
        colorFilter: const ColorFilter.mode(
          AppColor.mainColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
import 'package:am_adel_market/core/utils/app_imports.dart';

class SkeletonizerProductItem extends StatelessWidget {

  const SkeletonizerProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: const Color(0xff2B2B2B),
        highlightColor: const Color(0xff404040),
        duration: const Duration(milliseconds: 1200),
      ),
      enabled: true,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.card,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColor.mainColor.withOpacity(.1),
            width: 1,
          ),
      
        ),
        child: Stack(
          children: [
            Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Color(0xffEB5757),
                    )
      
                  ),
                ),
      
            Positioned.fill(
              top: 25.h,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
      
                  Flexible(
                    child: Image.asset(
                     Assets.assets.images.customer.path,
                      fit: BoxFit.contain,
      
                      ),
                    ),
                  SizedBox(height: 24.h),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                    ),
                    title: Text(
                      'product.name',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColor.textPrimary,
                      ),
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '10 ج.م',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                              color: AppColor.mainColor,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.right,
                    ),
                    trailing: GestureDetector(
                      child: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColor.mainColor,

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
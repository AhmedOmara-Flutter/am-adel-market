import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';

class OnBoardingImage extends StatelessWidget {
  final String image;

  const OnBoardingImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Transform.translate(
        offset: Offset(0, 175.h),
        child: Image.asset(
          image,
          width: 330.w,
          height: 330.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
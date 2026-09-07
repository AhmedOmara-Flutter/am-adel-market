import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/core/widgets/custom_back_button.dart';

class InfoActionRow extends StatelessWidget {
  final String text;
  final bool showBack;
  final bool showNotification;
  final bool showSearch;
  final double bottomPadding;
  final VoidCallback? searchOnPressed;

  const InfoActionRow({
    super.key,
    required this.text,
    this.showBack = false,
    this.showNotification = false,
    this.showSearch = false,
    this.bottomPadding = 20,
    this.searchOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 40.h,
        bottom: bottomPadding.h,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 60.w,
            width: 60.w,
            child: showBack ? const CustomBackButton() : const SizedBox(),
          ),

          Expanded(
            child: Center(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: AppColor.textPrimary,
                ),
              ),
            ),
          ),

          SizedBox(
            height: 60.w,
            width: 60.w,
            child: _buildRightAction(),
          ),
        ],
      ),
    );
  }

  Widget _buildRightAction() {
    if (showNotification) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: Material(
          color: AppColor.card,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(10.r),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 30.sp,
                    color: AppColor.mainColor,
                  ),
                  CircleAvatar(
                    radius: 4.r,
                    backgroundColor: const Color(0xffF24135),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (showSearch) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100.r),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100.r),
            onTap: searchOnPressed,
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: AppColor.card,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                  color: AppColor.border,
                  width: 1.w,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.assets.images.search.path,
                  width: 24.w,
                  height: 24.w,
                  colorFilter: const ColorFilter.mode(
                    AppColor.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox();
  }
}
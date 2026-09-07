import '../../../../core/utils/app_imports.dart';
import '../../../category/domain/entities/category_entity.dart';

class CategoriesTabBar extends StatelessWidget {
  const CategoriesTabBar({
    super.key,
    required this.controller,
    required this.categories,
    this.onTap,
  });

  final TabController controller;
  final List<CategoryEntity> categories;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: TabBar(
        controller: controller,
        onTap: onTap,

        splashFactory: NoSplash.splashFactory,

        isScrollable: true,
        tabAlignment: TabAlignment.start,

        indicator: BoxDecoration(
          color: AppColor.mainColor,
          borderRadius: BorderRadius.circular(25.r),
        ),

        indicatorSize: TabBarIndicatorSize.tab,

        labelColor: Colors.white,
        unselectedLabelColor: AppColor.textSecondary,

        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13.sp,
        ),

        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),

        dividerColor: Colors.transparent,

        overlayColor: WidgetStateProperty.all(
          Colors.transparent,
        ),

        splashBorderRadius: BorderRadius.circular(25.r),

        tabs: categories.map((category) {
          return Tab(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical: 8.h,
              ),
              child: Text(category.name),
            ),
          );
        }).toList(),
      ),
    );
  }
}
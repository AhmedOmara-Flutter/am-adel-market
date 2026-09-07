import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_imports.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.card,
            border: Border(
              top: BorderSide(
                color: AppColor.border,
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: context.read<MainCubit>().currentIndex,
            onTap: (index) {
              context.read<MainCubit>().changeBottomNav(index);
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColor.card,
            selectedItemColor: AppColor.mainColor,
            unselectedItemColor: AppColor.textSecondary,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            elevation: 0,
            selectedLabelStyle:StyleManager.font13Weight400.copyWith(color: AppColor.mainColor),
            unselectedLabelStyle:StyleManager.font13Weight400.copyWith(color: AppColor.white),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'الرئيسية',

              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_rounded),
                label: 'المنيو',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_rounded),
                label: 'السلة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'حسابي',
              ),
            ],
          ),
        );
      },
    );
  }
}
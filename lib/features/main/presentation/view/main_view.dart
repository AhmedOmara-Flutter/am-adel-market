import 'package:flutter/services.dart';
import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/cart/presentation/view_model/cart_cubit.dart';
import '../../../favorite/presentation/view_model/favorite_cubit.dart';

class MainView extends StatefulWidget {
  const MainView({super.key,});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteCubit>().getFavorites();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        final cubit = context.read<MainCubit>();
        if (cubit.currentIndex != 0) {
          cubit.changeBottomNav(0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavBar(),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: MultiBlocListener(
            listeners: [
              BlocListener<CartCubit, CartState>(listener: (context, state) {
                if (state is CartAdded) {
                  AppSounds.playClickSound('click_song.wav');
                  AppVibration.light();
                  // customShowSnakeBar(context, color: AppColor.mainColor,
                  //     label: 'تم إضافة المنتج إلى السلة');
                }
                if (state is CartRemoved) {
                  AppSounds.playClickSound('click_song.wav');
                  AppVibration.medium();
                  // customShowSnakeBar(context, color:AppColor.mainColor,
                  //     label: 'تم حذف المنتج من السلة');
                }
              },),
              BlocListener<FavoriteCubit, FavoriteState>(
                listener: (context, state) {
                  if (state is FavoriteAddedState) {
                    AppSounds.playClickSound('click_song.wav');
                    AppVibration.light();
                    // customShowSnakeBar(
                    //     context, color:AppColor.mainColor,
                    //     label: 'تمت الإضافة للمفضلة');
                  }
                  if (state is FavoriteDeletedState) {
                    AppSounds.playClickSound('click_song.wav');
                    AppVibration.medium();
                    // customShowSnakeBar(
                    //     context, color: AppColor.red, label: 'تم الحذف من المفضله');
                  }
                },),
            ],
            child: BlocBuilder<MainCubit, MainState>(
              builder: (context, state) {
                var cubit = context.read<MainCubit>();
                return IndexedStack(
                  index: cubit.currentIndex,
                  children: cubit.pages,
                );
              },
            ),
            ),
        ),
        ),
    );
  }
}

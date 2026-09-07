import 'package:am_adel_market/core/utils/app_imports.dart';
import 'package:am_adel_market/features/home/presentation/view/home_view.dart';
import '../../../cart/presentation/view/cart_view.dart';
import '../../../product/presentation/view/products_view.dart';
import '../../../profile/presentation/view/profile_view.dart';
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
   int currentIndex=0;
   List<Widget>pages=[
     HomeView(),
     ProductsView(),
     CartView(),
     ProfileView(),
   ];
   void changeBottomNav(int index){
     currentIndex=index;
     emit(ChangeBottomNavState());
   }
}

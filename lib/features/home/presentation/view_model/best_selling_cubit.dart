import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/repos/product_repo/product_repo.dart';

part 'best_selling_state.dart';

class BestSellingCubit extends Cubit<BestSellingState> {
  BestSellingCubit(this._productRepo) : super(BestSellingInitial());
  final ProductRepo _productRepo;
  List<ProductEntity> sellingProducts = [];

  void getSellingProducts() {
    emit(GetSellingProductsLoadingState());

    final data = _productRepo.getSellingProducts();

    data.listen((products) {
      products.fold(
        (failure) {
          print('Error: ${failure.errMessage}');
          emit(GetSellingProductsErrorState(errMessage: failure.errMessage));
        },
        (data) {
          if (data.isEmpty) {
            emit(GetSellingProductsEmptyState());
            return;
          }
          sellingProducts = data;
          emit(GetSellingProductsSuccessState(sellingProducts: data));
        },
      );
    });
  }

}

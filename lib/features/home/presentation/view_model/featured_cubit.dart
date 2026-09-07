import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/product_entity.dart';
import '../../../../core/repos/product_repo/product_repo.dart';

part 'featured_state.dart';

class FeaturedCubit extends Cubit<FeaturedState> {
  FeaturedCubit(this._productRepo) : super(FeaturedInitial());
  final ProductRepo _productRepo;
  List<ProductEntity> featuredProducts = [];

  void getFeaturedProducts() {
    emit(GetFeaturedProductsLoadingState());
    final products = _productRepo.getProducts();
    products.listen((data) {
      data.fold(
        (failure) {
          emit(GetFeaturedProductsErrorState(errMessage: failure.errMessage));
        },
        (data) {
          featuredProducts = data
              .where((element) => element.isFeatured == true)
              .toList();
          emit(
            GetFeaturedProductsSuccessState(featuredProducts: featuredProducts),
          );
        },
      );
    });
  }
}

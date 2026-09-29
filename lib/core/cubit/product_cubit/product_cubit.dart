import 'dart:async';

import 'package:am_adel_market/core/entities/product_entity.dart';
import 'package:am_adel_market/core/repos/product_repo/product_repo.dart';

import '../../../../core/utils/app_imports.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._productRepo) : super(ProductInitialState());
  final ProductRepo _productRepo;
  List<ProductEntity> filteredProducts = [];
  List<ProductEntity> allProducts = [];
  StreamSubscription? _productsSubscription;

  void getProducts() {
    print('🚀 ProductCubit.getProducts() تم استدعاؤها');

    _productsSubscription?.cancel();

    emit(GetProductsLoadingState());
    _productsSubscription= _productRepo.getProducts().listen((data) {
      data.fold(
            (failure) {
          emit(GetProductsErrorState(errMessage: failure.errMessage));
        },
            (data) {
          allProducts = data;
          filteredProducts = data;

          emit(GetProductsSuccessState(products: data));
        },
      );

    }

    );

  }

  ProductEntity? getProductById(String id) {
    return allProducts.firstWhere(
          (p) => p.id == id,
    );
  }

  Future<void> increaseSellingCount(String productId) async {
    final data = await _productRepo.increaseSellingCount(productId);
    data.fold((failure) {
      emit(IncreaseSellingCountErrorState(errMessage: failure.errMessage));
    }, (_) {});
  }

  void filterProducts(
      String category, {
        String? size,
      }) {
    final result = allProducts.where((product) {
      final categoryMatch = product.category == category;

      if (size == null) {
        return categoryMatch;
      }

      return categoryMatch && product.size == size;
    }).toList();

    filteredProducts = result;

    if (result.isEmpty) {
      emit(GetFilteredProductsEmpty());
    } else {
      emit(
        GetFilteredProductsSuccess(
          filterProducts: result,
        ),
      );
    }
  }

  void searchProducts(String value) {
    if (value.isEmpty) {
      filteredProducts = allProducts;
      emit(GetProductsSuccessState(products: allProducts));
      return;
    }

    final result = allProducts.where((product) {
      return product.name.toLowerCase().contains(value.toLowerCase());
    }).toList();

    filteredProducts = result;

    if (result.isEmpty) {
      emit(GetFilteredProductsEmpty());
    } else {
      emit(GetProductsSuccessState(products: result));
    }
  }

  Future<void> deleteCartCollectionForUser() async {
    emit(DeleteCartLoadingState());

    try {
      await _productRepo.deleteCollection('carts');

      emit(DeleteCartSuccessState());
    } catch (e) {
      emit(DeleteCartErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _productsSubscription?.cancel();
    return super.close();
  }
}

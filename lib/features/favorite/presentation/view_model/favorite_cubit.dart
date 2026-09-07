import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:am_adel_market/features/favorite/domain/repos/favorite_repo.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/product_entity.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit(this._favoriteRepo) : super(FavoriteInitial());
  final FavoriteRepo _favoriteRepo;
  Map<String, bool> favorites = {};
  StreamSubscription ?_favoriteStreamSubscription;

  Future toggleFavorite(ProductEntity product) async {
    final data = await _favoriteRepo.toggleFavorite(product);
    data.fold(
      (l) {
        print(l);
        emit(FavoriteToggledErrorState(errMessage: l));
      },
      (r) async {
        favorites[product.id] = r;

        if(r==true){
          emit(FavoriteAddedState());
        }else{
          emit(FavoriteDeletedState());
        }
          getFavorites();
      },
    );
  }

  void getFavorites() {

    emit(GetFavoriteLoadingState());
    try {
      _favoriteStreamSubscription =
          _favoriteRepo.getFavoriteProducts().listen((data) {
            data.fold(
                  (l) {
                log(l);
                emit(GetFavoriteErrorState(error: l));
              },
                  (favoritesProducts) {
                favorites.clear();
                for (var product in favoritesProducts) {
                  favorites[product.id] = true;
                }

                if (favoritesProducts.isEmpty) {
                  emit(GetFavoriteEmptyState());
                  return;
                }
                emit(GetFavoriteSuccessState(favoritesProducts));
              },
            );
          });

    } catch (e) {
      log(e.toString());
      emit(GetFavoriteErrorState(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _favoriteStreamSubscription!.cancel();
    return super.close();
  }
}

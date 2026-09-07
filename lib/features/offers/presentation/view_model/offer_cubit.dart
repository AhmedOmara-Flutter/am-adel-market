import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/offer_entity.dart';
import '../../../../core/repos/offer_repo/offer_repo.dart';
import '../../../../core/repos/product_repo/product_repo.dart';

part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit(this._offerRepo, this._productRepo) : super(OffersInitial());
  final OfferRepo _offerRepo;
  final ProductRepo _productRepo;
  List<OfferEntity> offers = [];
  Map<String, OfferEntity> offersMap = {};
  StreamSubscription ?_offerStreamSubscription;


  void getOffers() {
    emit(GetOffersLoading());
    _offerStreamSubscription = _offerRepo.getOffers().listen((result) {
      result.fold(
            (failure) {
          emit(GetOffersFailure(failure.errMessage));
        },
            (offers) {
          this.offers = offers;
          offersMap = {};
          for (var offer in offers) {
            offersMap[offer.productId] = offer;
          }
          if (offers.any((offer) => offer.isExpired)) {
             _productRepo.deleteCollection('carts');
          }

          if (offers.isEmpty) {
            emit(GetOffersEmpty());
          } else {
            emit(GetOffersSuccess(offers, offersMap));
          }
        },
      );
    });  }

  Future<void> deleteOffer(String offerId) async {
    emit(DeleteOfferLoading());
    final result = await _offerRepo.deleteOffer(offerId);
    await result.fold(
      (failure) async {
        emit(DeleteOfferFailure(failure.errMessage));
      },
      (success) async {
        emit(DeleteOfferSuccess());
      },
    );
  }

  void resetState() {
    emit(OffersInitial());
  }

  @override
  Future<void> close() {
    _offerStreamSubscription?.cancel();
    return super.close();
  }
}

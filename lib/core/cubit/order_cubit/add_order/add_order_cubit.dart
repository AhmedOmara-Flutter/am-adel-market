import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../entities/order_entity.dart';
import '../../../repos/order_repo/order_repo.dart';

part 'add_order_state.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this._orderRepo) : super(AddOrderInitial());
  final OrderRepo _orderRepo;


  Future<void> addOrder(OrderEntity orderEntity) async {
    emit(CheckoutAddOrderLoading());

    await Future.delayed(
      const Duration(seconds: 2),
    );
    final result = await _orderRepo.addOrder(orderEntity);

    result.fold(
          (failure) {
        return emit(CheckoutAddOrderError(failure.errMessage));
      },
          (data) {
        orderEntity.id = data;
        emit(CheckoutAddOrderSuccess());
      },
    );
  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/logics/cart_api.dart';
import 'package:my_project/models/cart_list/cart_list.dart';

part 'carts_state.dart';

class CartsCubit extends Cubit<CartsState> {
  final CartService cartService = CartService();

  CartsCubit() : super(CartsInitial());

  Future<void> fetchData() async {
    emit(CartsLoading());

    try {
      CartList? cart = await cartService.fetchCart();
      if (cart != null) {
        emit(CartsSuccess(cart));
      } else {
        emit(CartsFail('Error'));
      }
    } catch (e) {
      emit(e.toString() as CartsState);
    }
  }
}

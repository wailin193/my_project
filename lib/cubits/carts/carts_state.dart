part of 'carts_cubit.dart';

@immutable
class CartsState {}

class CartsInitial extends CartsState {}

class CartsLoading extends CartsState {}

class CartsSuccess extends CartsState {
  final CartList cartList;
  final CartService cartService = CartService();

  CartsSuccess(this.cartList);
}

class CartsFail extends CartsState {
  final String error;

  CartsFail(this.error);
}

part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  ProductList productList;
  ProductSuccess(this.productList);
}

class ProductFail extends ProductState {
  final String error;
  ProductFail(this.error);
}

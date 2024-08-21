part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  ProductMain productMain;

  ProductSuccess(this.productMain);
}

class ProductFail extends ProductState {
  final String error;
  ProductFail(this.error);
}

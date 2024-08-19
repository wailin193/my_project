// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:meta/meta.dart';
// import 'package:my_project/logics/product_api.dart';
// import 'package:my_project/models/Product.dart';
//
// part 'product_state.dart';
//
// class ProductCubit extends Cubit<ProductState> {
//   ProductCubit() : super(ProductInitial());
//
//   final ProductApi _productApi = ProductApi();
//
//   Future<void> fetchProduct() async {
//     emit(ProductLoading());
//     try {
//       ProductList productList = await _productApi.fetchProduct();
//     emit(ProductSuccess(productList));
//     } catch (e) {
//     emit(ProductFail(e.toString()),
//     );
//   }
// }}

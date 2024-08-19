// import 'package:dio/dio.dart';
// import '../models/Product.dart';
//
// class ProductApi{
//   Future<ProductList> fetchProduct() async{
//     const String apiUrl = 'https://dummyjson.com/products';
//     try{
//       Response response = await Dio().get(apiUrl);
//       if(response.data != null){
//         return ProductList.fromJson(response.data);
//       }else{
//         throw Exception("Api Response is null");
//       }
//     }catch (e){
//       throw Exception(e.toString());
//     }
//   }
// }

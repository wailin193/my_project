import 'package:dio/dio.dart';

class ProductApi{
  Future<String> fetchProduct() async{
    const String apiUrl = 'https://dummyjson.com/products/category-list';
    try{
      Response response = await Dio().get(apiUrl);
      if(response.data != null){
        return response.data;
      }else{
        throw Exception("Api Response is null");
      }
    }catch (e){
      throw Exception(e.toString());
    }
  }
}
import 'package:dio/dio.dart';
import '../models/product_list/product_main.dart';

class ProductApi{
  Future<ProductMain> fetchProduct() async{
    const String apiUrl = 'https://dummyjson.com/products';
    try{
      Response response = await Dio().get(apiUrl);
      if(response.data != null){
        return ProductMain.fromJson(response.data);
      }else{
        throw Exception("Api Response is null");
      }
    }catch (e){
      throw Exception(e.toString());
    }
  }
}

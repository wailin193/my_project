import 'package:dio/dio.dart';
import 'package:my_project/models/cart_list/cart_list.dart';

class CartService{
  Future<CartList?> fetchCart() async{
    const String apiUrl = 'https://dummyjson.com/carts';
    try{
      Response response = await Dio().get(apiUrl);
      if(response.data != null){
        return CartList.fromJson(response.data);
      }else{
        throw Exception("Api Response is null");
      }
    }catch (e){
      throw Exception(e.toString());
    }
  }
}

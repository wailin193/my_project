import 'package:dio/dio.dart';

class CategoryApi{
  Future<List<String>> fetchCategory() async{
    const String apiUrl = 'https://dummyjson.com/products/category-list';
    try{
      Response response = await Dio().get(apiUrl);
      if(response.data != null){
        print(response.data);
        List<String> list = [];
        (response.data as List<dynamic>).forEach((element) {
          list.add(element.toString());
        });
        return list;
      }else{
        throw Exception("Api Response is null");
      }
    }catch (e){
      throw Exception(e.toString());
    }
  }
}
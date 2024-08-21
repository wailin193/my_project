import 'dart:convert';

import 'package:my_project/models/product_list/product_list.dart';
ProductMain productFromJson(String str) => ProductMain.fromJson(json.decode(str)); //from Json
String productToJson(ProductMain data) => json.encode(data.toJson()); //to Json
class ProductMain {
  ProductMain({
      this.products,});

  ProductMain.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductList.fromJson(v));
      });
    }
  }
  List<ProductList>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}


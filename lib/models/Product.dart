import 'dart:convert';
ProductList productFromJson(String str) => ProductList.fromJson(json.decode(str)); //from Json
String productToJson(ProductList data) => json.encode(data.toJson()); //to Json
class ProductList {
  ProductList({
      this.products,});

  ProductList.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
  }
  List<Product>? products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Product productsFromJson(String str) => Product.fromJson(json.decode(str));
String productsToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      this.id,
      this.title,
      this.description,
      this.category,
      this.price,
      this.thumbnail,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    thumbnail = json['thumbnail'];
  }
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['price'] = price;
    map['thumbnail'] = thumbnail;
    return map;
  }

}
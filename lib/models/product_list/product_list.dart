import 'dart:convert';

ProductList productsFromJson(String str) => ProductList.fromJson(json.decode(str));
String productsToJson(ProductList data) => json.encode(data.toJson());
class ProductList {
  ProductList({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.minimumOrderQuantity,
    this.thumbnail,});

  ProductList.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'].toDouble();
    discountPercentage = json['discountPercentage'].toDouble();
    rating = json['rating'].toDouble();
    minimumOrderQuantity = json['minimumOrderQuantity'];
    thumbnail = json['thumbnail'];
  }
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? minimumOrderQuantity;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['price'] = price;
    map['discountPercentage'] = discountPercentage;
    map['thumbnail'] = thumbnail;
    return map;
  }

}
import 'carts.dart';

class CartList {
  List<Cart>? carts;
  int? total;
  int? skip;
  int? limit;

  CartList({this.carts, this.total, this.skip, this.limit});

  CartList.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = <Cart>[];
      json['carts'].forEach((v) {
        carts!.add(Cart.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.carts != null) {
      data['carts'] = this.carts!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['skip'] = this.skip;
    data['limit'] = this.limit;
    return data;
  }
}





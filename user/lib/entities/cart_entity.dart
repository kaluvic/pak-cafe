import 'dart:convert';

class Cart {
  String? orderId;
  List<Item>? items;
}

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    required this.itemId,
    required this.name,
    required this.count,
    required this.note,
    required this.status,
    required this.toppings,
    required this.price,
  });

  String itemId;
  String name;
  int count;
  String note;
  String status;
  String toppings;
  double price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemId: json["itemId"],
        name: json["name"],
        count: json["count"],
        note: json["note"],
        status: json["status"],
        toppings: json["toppings"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "itemId": itemId,
        "name": name,
        "count": count,
        "note": note,
        "status": status,
        "toppings": toppings,
        "price": price,
      };
}

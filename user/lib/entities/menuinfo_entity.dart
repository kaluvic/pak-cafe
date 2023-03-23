// To parse this JSON data, do
//
//     final menuInfo = menuInfoFromJson(jsonString);

import 'dart:convert';

Map<String, MenuInfo> menuInfoFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, MenuInfo>(k, MenuInfo.fromJson(v)));

String menuInfoToJson(Map<String, MenuInfo> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class MenuInfo {
  MenuInfo({
    required this.name,
    required this.price,
    required this.status,
    this.toppings,
  });

  String name;
  double price;
  Status status;
  List<Topping>? toppings;

  factory MenuInfo.fromJson(Map<String, dynamic> json) => MenuInfo(
        name: json["name"],
        price: (json["price"] as int).toDouble(),
        status: Status.fromJson(json["status"]),
        toppings: json["toppings"] == null
            ? []
            : List<Topping>.from(
                json["toppings"]!.map((x) => Topping.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "status": status.toJson(),
        "toppings": toppings == null
            ? []
            : List<dynamic>.from(toppings!.map((x) => x.toJson())),
      };
}

class Status {
  Status({
    required this.frappe,
    required this.hot,
    required this.ice,
  });

  double frappe;
  double hot;
  double ice;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        frappe: (json["frappe"] as int).toDouble(),
        hot: (json["hot"] as int).toDouble(),
        ice: (json["ice"] as int).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "frappe": frappe,
        "hot": hot,
        "ice": ice,
      };
}

class Topping {
  Topping({
    required this.name,
    required this.price,
  });

  String name;
  double price;

  factory Topping.fromJson(Map<String, dynamic> json) => Topping(
        name: json["name"],
        price: (json["price"] as int).toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
      };
}

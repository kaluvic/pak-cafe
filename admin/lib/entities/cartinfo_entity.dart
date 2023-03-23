import 'dart:convert';

Map<String, CartInfo> cartInfoFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, CartInfo>(k, CartInfo.fromJson(v)));

String cartInfoToJson(Map<String, CartInfo> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class CartInfo {
    CartInfo({
        required this.count,
        required this.menuName,
        required this.note,
        required this.status,
        required this.toppings,
    });

    int count;
    String menuName;
    String note;
    String status;
    String toppings;

    factory CartInfo.fromJson(Map<String, dynamic> json) => CartInfo(
        count: json["count"],
        menuName: json["menuName"],
        note: json["note"],
        status: json["status"],
        toppings: json["toppings"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "menuName": menuName,
        "note": note,
        "status": status,
        "toppings": toppings,
    };
}

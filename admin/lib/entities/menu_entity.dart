// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

Menu menuFromJson(String str) => Menu.fromJson(json.decode(str));

String menuToJson(Menu data) => json.encode(data.toJson());

class Menu {
  Menu({
    required this.category,
    required this.recommend,
  });

  List<Category> category;
  List<String> recommend;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        recommend: List<String>.from(json["recommend"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "recommend": List<dynamic>.from(recommend.map((x) => x)),
      };
}

class Category {
  Category({
    required this.menuId,
    required this.name,
  });

  List<String> menuId;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        menuId: List<String>.from(json["menuId"].map((x) => x)),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "menuId": List<dynamic>.from(menuId.map((x) => x)),
        "name": name,
      };
}

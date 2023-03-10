// To parse this JSON data, do
//
//     final menuList = menuListFromJson(jsonString);

import 'dart:convert';

MenuList menuListFromJson(String str) => MenuList.fromJson(json.decode(str));

String menuListToJson(MenuList data) => json.encode(data.toJson());

class MenuList {
  MenuList({
    required this.category,
    required this.recommend,
  });

  List<Category> category;
  List<String> recommend;

  factory MenuList.fromJson(Map<String, dynamic> json) => MenuList(
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

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:pak_user/entities/menuinfo_entity.dart';

import '../entities/menulist_entity.dart';

class MenuService {
  final ref = FirebaseDatabase.instance.ref();

  /// Fetch Menu data
  Future<MenuList?> fetchMenuList() async {
    return await ref.child('menu').once().then((event) {
      String json = jsonEncode(event.snapshot.value);
      MenuList? menuList = menuListFromJson(json);
      return menuList;
    });
  }

  Future<Map<String, MenuInfo>> fetchInfo() async {
    return await ref.child('menuInfo').once().then((event) {
      String json = jsonEncode(event.snapshot.value);
      Map<String, MenuInfo> menuInfo = menuInfoFromJson(json);
      return menuInfo;
    });
  }

  Future<MenuInfo> fetchInfoFromId(String menuId) async {
    return await ref.child('menuInfo/$menuId').once().then((event) {
      String json = jsonEncode(event.snapshot.value);
      MenuInfo menuInfo = MenuInfo.fromJson(jsonDecode(json));
      return menuInfo;
    });
  }
}

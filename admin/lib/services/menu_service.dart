import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menu_entity.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';
import 'package:pak_admin/widgets/add_cat.dart';
import 'package:pak_admin/widgets/drink_list.dart';

class MenuService {
  final ref = FirebaseDatabase.instance.ref();

  //* Fetch menu from firebase
  Future<Menu> fetchMenu() async {
    return await ref.child("menu").once().then(
      (event) {
        String json = jsonEncode(event.snapshot.value);
        Menu menu = menuFromJson(json);
        return menu;
      },
    );
  }

  Future<Map<String, MenuInfo>> fetchMenuInfo() async {
    return await ref.child("menuInfo").once().then(
      (event) {
        String json = jsonEncode(event.snapshot.value);
        final menuinfo = menuInfoFromJson(json);
        return menuinfo;
      },
    );
  }

  //* Create menu tab
  List<List<Widget>> createTabview(
      List<Category> catList, Map<String, MenuInfo> menuMap) {
    List<List<Widget>> tabviews = [[], []];
    for (var cat in catList) {
      tabviews.first.add(Tab(
        text: cat.name,
      ));
      tabviews.last.add(DrinkList(
        menuIdList: cat.menuId,
        menuInfoMap: menuMap,
      ));
    }
    tabviews.first.add(const Tab(text: '+'));
    tabviews.last.add(const CategoryAdd());
    return tabviews;
  }
}

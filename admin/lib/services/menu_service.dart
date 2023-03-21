import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menu_entity.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';
import 'package:pak_admin/widgets/add_cat.dart';
import 'package:pak_admin/widgets/drink_list.dart';
import 'package:uuid/uuid.dart';

class MenuService {
  final ref = FirebaseDatabase.instance.ref();

  // Fetch menu from firebase
  Future<Menu> fetchMenu() async {
    return await ref.child("menu").once().then(
      (event) {
        String json = jsonEncode(event.snapshot.value);
        Menu menu = menuFromJson(json);
        return menu;
      },
    );
  }

  Future<Menu?> listenMenu() async {
    Menu? menu;
    ref.child('menu').onValue.listen((event) {
      String json = jsonEncode(event.snapshot.value);
      menu = menuFromJson(json);
    });
    return menu ?? await fetchMenu();
  }

  // Fetch all menu's info
  Future<Map<String, MenuInfo>> fetchMenuInfo() async {
    return await ref.child("menuInfo").once().then(
      (event) {
        String json = jsonEncode(event.snapshot.value);
        final menuinfo = menuInfoFromJson(json);
        return menuinfo;
      },
    );
  }

  Future<Map<String, MenuInfo>> listenMenuInfo() async {
    Map<String, MenuInfo>? menuinfo;
    ref.child('menuInfo').onValue.listen((event) {
      String json = jsonEncode(event.snapshot.value);
      menuinfo = menuInfoFromJson(json);
    });
    return menuinfo ?? await fetchMenuInfo();
  }

  // Create menu tab
  List<List<Widget>> createTabview(
      List<Category> catList, Map<String, MenuInfo> menuMap) {
    List<List<Widget>> tabviews = [[], []];
    int index = 0;
    for (var cat in catList) {
      tabviews.first.add(Tab(
        text: cat.name,
      ));
      tabviews.last.add(DrinkList(
        category: cat.name,
        catIndex: index,
        menuIdList: cat.menuId,
        menuInfoMap: menuMap,
      ));
      index += 1;
    }
    tabviews.first.add(const Tab(text: '+'));
    tabviews.last.add(const CategoryAdd());
    return tabviews;
  }

  // Update menulist in database
  void updateMenu(
      {required String name,
      required String price,
      required Status status,
      required bool isRecommend,
      required List<Topping> toppings,
      required bool isEdit,
      required String id,
      required String category,
      required int catIndex}) {
    double priceAsDouble = double.parse(price);
    MenuInfo menu = MenuInfo(
        name: name, price: priceAsDouble, status: status, toppings: toppings);
    if (isEdit) {
      // UPDATE
      ref
          .child('menuInfo/$id')
          .update(menu.toJson())
          .then((value) => print('Update successfully'));
    } else {
      // ADD
      var uuid = const Uuid();
      var genId = uuid.v4();
      id = genId;
      ref
          .child('menuInfo/$genId')
          .set(menu.toJson())
          .then((value) => print('Update successfully'));
      //TODO: Add new menuId to category
      var menuRef = ref.child('menu/category/$catIndex/menuId');
      menuRef.once().then((event) {
        List<dynamic> temp = event.snapshot.value as List;
        int length = temp.length;
        menuRef.update({'$length': genId});
      });
    }
    if (isRecommend) {
      var recRef = ref.child('menu/recommend');
      recRef.once().then((event) {
        List<dynamic> temp = event.snapshot.value as List;
        int length = temp.length;
        recRef.update({'$length': id});
      });
    }
  }
}

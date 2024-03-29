/// ธัชทร วงศ์ไชย 620510601
/// MenuPage
/// แสดงหน้าเมนูต่างประกอบไปด้วย Category tab และรายการเครื่องดื่มในแต่ละประเภท

import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menu_entity.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';
import 'package:pak_admin/services/menu_service.dart';

import '../theme/customtheme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<List<Widget>> tabviews = [[], []];

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    MenuService menuService = MenuService();
    late Menu menu;
    late Map<String, MenuInfo> menuMap;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เมนู",
          style:
              TextStyle(fontWeight: FontWeight.w600, color: CoffeeColor.milk),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Future.wait(
              [menuService.listenMenu(), menuService.listenMenuInfo()]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              menu = snapshot.data!.first;
              menuMap = snapshot.data!.last;
              tabviews = menuService.createTabview(menu.category, menuMap);
              return DefaultTabController(
                  length: tabviews[0].length,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Container(
                        child: TabBar(
                            labelColor: CoffeeColor.cream,
                            unselectedLabelColor: CoffeeColor.coffee,
                            indicatorColor: CoffeeColor.cream,
                            labelStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                            tabs: tabviews.first),
                      ),
                      //* BODY
                      Expanded(
                          child: SizedBox(
                              child: TabBarView(children: tabviews.last)))
                    ],
                  ));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

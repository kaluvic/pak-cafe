import 'package:flutter/material.dart';
import 'package:pak_admin/entities/menu_entity.dart';
import 'package:pak_admin/entities/menuinfo_entity.dart';
import 'package:pak_admin/services/menu_service.dart';

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
        title: const Text("เมนู"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Future.wait(
              [menuService.fetchMenu(), menuService.fetchMenuInfo()]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              menu = snapshot.data!.first;
              menuMap = snapshot.data!.last;
              tabviews = menuService.createTabview(menu.category, menuMap);
              return Column(
                children: [
                  DefaultTabController(
                      length: tabviews[0].length,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          Container(
                            child: TabBar(
                                labelColor: Colors.blue,
                                unselectedLabelColor: Colors.black,
                                tabs: tabviews.first),
                          ),
                          //* BODY
                          SizedBox(
                            height: heightScreen * 0.3,
                            child: TabBarView(children: tabviews.last),
                          )
                        ],
                      )),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}

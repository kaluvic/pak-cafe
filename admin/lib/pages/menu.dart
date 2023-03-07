import 'package:flutter/material.dart';
import 'package:pak_admin/widgets/add_cat.dart';
import 'package:pak_admin/widgets/drink_list.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<List<Widget>> tabviews = [
    [
      const Tab(
        text: 'กาแฟ',
      ),
      const Tab(
        text: 'ชา',
      ),
      const Tab(
        text: '+',
      )
    ],
    [const DrinkList(), const DrinkList(), const CategoryAdd()]
  ];

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("เมนู"),
        centerTitle: true,
      ),
      body: Column(
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
      ),
    );
  }
}

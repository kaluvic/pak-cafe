/// ธัชทร วงศ์ไชย 620510601
/// HomePage
/// หน้าจอหลักของแอพ
/// Feature แสดงภาพเมนูแนะนำ มีปัญหาในการเก็บรูปภาพลง Firebase

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pak_user/entities/menuinfo_entity.dart';
import 'package:pak_user/pages/menu_order.dart';
import 'package:pak_user/services/menu_service.dart';
import 'package:pak_user/pages/cart.dart';
import 'package:pak_user/theme/customtheme.dart';
import '../entities/menulist_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MenuList _menuList;
  late Map<String, MenuInfo> _menuMap;
  MenuService menuService = MenuService();

  void onMenuTap(MenuInfo menuInfo, String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MenuOrderPage(menuInfo: menuInfo, menuid: id),
        ));
  }

  void _onCartTapped() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ));
  }

  List<Tab> generateTab() {
    return List<Tab>.generate(_menuList.category.length, (index) {
      return Tab(
        child: Text(
          _menuList.category[index].name,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
        ),
      );
    }).toList();
  }

  List<Widget> generatePage() {
    return List<Widget>.generate(_menuList.category.length, (index) {
      List<String> menuIdList = _menuList.category[index].menuId;
      return ListView.builder(
        itemCount: menuIdList.length,
        itemBuilder: (context, i) {
          if (i > 0) {
            MenuInfo info = _menuMap[menuIdList[i]]!;
            String price = NumberFormat.decimalPatternDigits(decimalDigits: 0)
                .format(info.price);
            return ListTile(
              title: Text(info.name),
              subtitle: Text('ราคา: $price บาท'),
              onTap: () {
                onMenuTap(info, menuIdList[i]);
              },
            );
          } else {
            return Container();
          }
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onCartTapped,
        child: const Icon(Icons.shopping_cart),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
            child: FutureBuilder(
          future: Future.wait(
              [menuService.fetchMenuList(), menuService.fetchInfo()]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              _menuList = snapshot.data![0];
              _menuMap = snapshot.data![1];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //* Recommend menu slider
                  CarouselSlider(
                    options: CarouselOptions(
                        autoPlay: true, height: (0.3 * heightScreen)),
                    items: ['pic', 'pic2', 'pic3', 'pic4', 'pic5'].map((e) {
                      return Builder(
                        builder: (context) {
                          return Container(
                              width: widthScreen,
                              decoration:
                                  const BoxDecoration(color: Colors.amber),
                              child: Image.asset(
                                'assets/images/$e.png',
                                fit: BoxFit.cover,
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                          top: 10.0, bottom: 10.0, left: 10.0),
                      child: const Text(
                        'Menu',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      )),
                  // * Tab Category
                  DefaultTabController(
                      length: _menuList.category.length,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          Container(
                            child: TabBar(
                                indicatorColor: CoffeeColor.coffee,
                                labelColor: CoffeeColor.cream,
                                unselectedLabelColor: CoffeeColor.coffee,
                                tabs: generateTab()),
                          ),
                          //* BODY
                          SizedBox(
                            height: heightScreen * 0.3,
                            child: TabBarView(children: generatePage()),
                          )
                        ],
                      ))
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        )),
      )),
    );
  }
}

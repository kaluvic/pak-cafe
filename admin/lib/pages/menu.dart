import 'package:flutter/material.dart';
import 'package:pak_admin/pages/menu_add.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  void goMenuAddPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MenuAddPage()));
  }

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
              length: 5,
              initialIndex: 0,
              child: Column(
                children: [
                  Container(
                    child: const TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'กาแฟ',
                          ),
                          Tab(
                            text: 'ชา',
                          ),
                          Tab(
                            text: 'นม',
                          ),
                          Tab(
                            text: 'ขนม',
                          ),
                          Tab(
                            text: "+",
                          )
                        ]),
                  ),
                  //* BODY
                  SizedBox(
                    height: heightScreen * 0.3,
                    child: TabBarView(children: [
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return ListTile(
                              title: const Text('+'),
                              onTap: goMenuAddPage,
                            );
                          } else {
                            return ListTile(
                              title: Text('$index'),
                            );
                          }
                        },
                      ),
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const ListTile(
                              title: Text('+'),
                            );
                          } else {
                            return ListTile(
                              title: Text('$index'),
                            );
                          }
                        },
                      ),
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const ListTile(
                              title: Text('+'),
                            );
                          } else {
                            return ListTile(
                              title: Text('$index'),
                            );
                          }
                        },
                      ),
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const ListTile(
                              title: Text('+'),
                            );
                          } else {
                            return ListTile(
                              title: Text('$index'),
                            );
                          }
                        },
                      ),
                      ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return const ListTile(
                              title: Text('+'),
                            );
                          } else {
                            return ListTile(
                              title: Text('$index'),
                            );
                          }
                        },
                      ),
                    ]),
                  )
                ],
              ))
        ],
      ),
    );
  }
}

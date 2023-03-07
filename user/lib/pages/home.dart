import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pak_user/pages/menu_order.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onMenuTap() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MenuOrderPage(),
        ));
  }

  void _onCartTapped() {
    //TODO: Go to Menu order.
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //* Recommend menu slider
              CarouselSlider(
                options: CarouselOptions(autoPlay: true, height: 400.0),
                items: [1, 2, 3, 4, 5].map((e) {
                  return Builder(
                    builder: (context) {
                      return Container(
                        width: widthScreen,
                        decoration: const BoxDecoration(color: Colors.amber),
                        child: Text(
                          '$e',
                          style: const TextStyle(fontSize: 50),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 10.0, bottom: 10.0, left: 10.0),
                  child: const Text(
                    'Menu',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
              // * Tab Category
              DefaultTabController(
                  length: 4,
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
                            ]),
                      ),
                      //* BODY
                      SizedBox(
                        height: heightScreen * 0.3,
                        child: TabBarView(children: [
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('$index'),
                                onTap: () {
                                  onMenuTap();
                                },
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('$index'),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('$index'),
                              );
                            },
                          ),
                          ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text('$index'),
                              );
                            },
                          ),
                        ]),
                      )
                    ],
                  ))
            ],
          ),
        ),
      )),
    );
  }
}

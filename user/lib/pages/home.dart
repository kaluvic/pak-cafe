import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double cash = 1000;
  String username = 'Chanin';
  int _selectedIndex = 0;

  void dropdownCallback(String? selectedValue) {
    if (selectedValue == 'logout') {
      print('Logout');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCartTapped() {
    //TODO: Go to Menu order.
  }

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton<String>(
                value: 'default',
                items: [
                  DropdownMenuItem(
                      value: 'default',
                      child: Text(
                        username,
                      )),
                  const DropdownMenuItem(
                      value: 'logout', child: Text('Logout')),
                ],
                onChanged: dropdownCallback),
            Text(NumberFormat.currency(symbol: '฿').format(cash))
          ],
        ),
      ),
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
              //* Recommend menu
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
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: const Text('Menu')),
              // * Tab Category
              DefaultTabController(
                  length: 4,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      Container(
                        child: const TabBar(
                            labelColor: Colors.green,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                text: '1',
                              ),
                              Tab(
                                text: '2',
                              ),
                              Tab(
                                text: '3',
                              ),
                              Tab(
                                text: '4',
                              ),
                            ]),
                      ),
                      //* BODY
                      SizedBox(
                        height: heightScreen * 0.3,
                        child: const TabBarView(children: [
                          Center(
                            child: Text('1'),
                          ),
                          Center(
                            child: Text('2'),
                          ),
                          Center(
                            child: Text('3'),
                          ),
                          Center(
                            child: Text('4'),
                          )
                        ]),
                      )
                    ],
                  ))
            ],
          ),
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menu'),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu_book), label: 'Order'),
          ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:pak_user/pages/home.dart';
import 'package:pak_user/pages/order.dart';
import 'package:intl/intl.dart';

class NavaigationPage extends StatefulWidget {
  const NavaigationPage({super.key});

  @override
  State<NavaigationPage> createState() => _NavaigationPageState();
}

class _NavaigationPageState extends State<NavaigationPage> {
  double cash = 1000;
  String username = 'Chanin';
  int selectedIndex = 0;

  void dropdownCallback(String? selectedValue) {
    if (selectedValue == 'logout') {
      print('Logout');
    }
  }

  

  @override
  Widget build(BuildContext context) {
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
      body: IndexedStack(
        index: selectedIndex,
        children: const [HomePage(), OrderPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.dining), label: 'Order'),
          ]),
    );
  }
}

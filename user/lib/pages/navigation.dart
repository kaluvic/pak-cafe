import 'package:flutter/material.dart';
import 'package:pak_user/pages/home.dart';
import 'package:pak_user/pages/order.dart';

class NavaigationPage extends StatefulWidget {
  const NavaigationPage({super.key});

  @override
  State<NavaigationPage> createState() => _NavaigationPageState();
}

class _NavaigationPageState extends State<NavaigationPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

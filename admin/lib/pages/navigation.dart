import 'package:flutter/material.dart';
import 'package:pak_admin/pages/credit_management.dart';
import 'package:pak_admin/pages/credit_search_user.dart';
import 'package:pak_admin/pages/menu.dart';
import 'package:pak_admin/pages/order_page.dart';

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
        children: const [
          OrderPage(),
          MenuPage(),
          CreditSearchUserPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dining), label: 'Order'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Credit'),
          ]),
    );
  }
}

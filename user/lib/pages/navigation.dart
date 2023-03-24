import 'package:flutter/material.dart';
import 'package:pak_user/entities/userlist_entity.dart';
import 'package:pak_user/pages/home.dart';
import 'package:pak_user/pages/login.dart';
import 'package:pak_user/pages/order.dart';
import 'package:intl/intl.dart';
import 'package:pak_user/services/user_service.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final userService = UserService();
  double cash = 0;
  String username = '';
  String userId = '';
  int selectedIndex = 0;
  Map<String, dynamic> user = {};

  Future<void> dropdownCallback(String? selectedValue) async {
    if (selectedValue == 'logout') {
      userService.clearUserCache();

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
    }
  }

  Future<void> updateUserCredit(String userId) async {
    Map<String, UserList> userList = await userService.fetchUser();
    Map<String, dynamic> user = await userService.getUserInfo();
    userList.forEach((key, value) {
      if (value.userId == user['userId']) {
        setState(() {
          cash = value.credit;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userService.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data!;
            username = user['name'];
            userId = user['userId'];
            cash = user['credit'];
            return RefreshIndicator(
              onRefresh: () async {
                await updateUserCredit(userId);
              },
              child: Scaffold(
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
                      BottomNavigationBarItem(
                          icon: Icon(Icons.menu_book), label: 'Menu'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.dining), label: 'Order'),
                    ]),
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

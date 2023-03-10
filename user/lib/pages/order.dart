import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pak_user/widgets/order_status_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  double cash = 1000;
  String username = 'Chanin';

  void dropdownCallback(String? selectedValue) {
    if (selectedValue == 'logout') {
      print('Logout');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Column(
                children: const [
                  Text(
                    "สถานะการสั่งซื้อ",
                    style: TextStyle(fontSize: 30),
                  ),
                  OrderStatusCardWidget(),
                  OrderStatusCardWidget()
                ],
              )),
        ),
      ),
    );
  }
}

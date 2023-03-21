import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pak_user/widgets/order_status_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  double cash = 1000;
  String username = 'Chanin';
  String uid = '72cdf7df-eb6c-4cb6-9216-a85a3d330205';

  void dropdownCallback(String? selectedValue) {
    if (selectedValue == 'logout') {
      print('Logout');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
          query: FirebaseDatabase.instance.ref('order/$uid/orderList'),
          itemBuilder: (context, snapshot, animation, index) {
            return OrderStatusCardWidget(
              orderId: snapshot.child('orderId').value.toString(),
              orderStatus: int.parse(snapshot.child('status').value.toString()),
              time: snapshot.child('time').value.toString(),
            );
          }),
    );
  }
}

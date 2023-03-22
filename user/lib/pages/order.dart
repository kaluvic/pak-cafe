import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pak_user/services/user_service.dart';
import 'package:pak_user/widgets/order_status_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  double cash = 0;
  String username = '';
  String uid = '';
  final userService = UserService();
  Map<String, dynamic> user = {};

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userService.getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data!;
            username = user['name'];
            uid = user['userId'];
            cash = user['credit'];
            return Scaffold(
              body: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance.ref('order/$uid/orderList'),
                  itemBuilder: (context, snapshot, animation, index) {
                    return OrderStatusCardWidget(
                      orderId: snapshot.child('orderId').value.toString(),
                      orderStatus:
                          int.parse(snapshot.child('status').value.toString()),
                      time: snapshot.child('time').value.toString(),
                    );
                  }),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

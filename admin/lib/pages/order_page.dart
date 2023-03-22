import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pak_admin/entities/cartinfo_entity.dart';
import 'package:pak_admin/widgets/order_card.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int statusIndex = -1;
  String divideText = 'error';

  Widget genDivideText(int current) {
      switch (current) {
        case 0:
          divideText = 'รอรับออเดอร์';
          break;
        case 1:
          divideText = 'กำลังดำเนินการ';
          break;
        case 2:
          divideText = 'ออเดอร์เสร็จสิ้น';
          break;
        default:
      }
      statusIndex = current;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(
              indent: 20.0,
              endIndent: 10.0,
              thickness: 1,
            ),
          ),
          Text(
            divideText,
            style: const TextStyle(color: Colors.blueGrey),
          ),
          const Expanded(
            child: Divider(
              indent: 10.0,
              endIndent: 20.0,
              thickness: 1,
            ),
          ),
        ],
      );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAnimatedList(
          query: FirebaseDatabase.instance
              .ref('orderInfo/')
              .orderByChild('status'),
          itemBuilder: (context, snapshot, animation, index) {
            
            String data =jsonEncode(snapshot.child('menuList').value);
            Map<String,CartInfo> cartInfo = cartInfoFromJson(data);
            print(cartInfo);
            return Column(
              children: [
                genDivideText(
                    int.parse(snapshot.child('status').value.toString())),
                OrderCardWidget(
                  cartInfo: cartInfo,
                  username: snapshot.child('username').value.toString(),
                  status: int.parse(snapshot.child('status').value.toString()),
                  orderId: snapshot.key.toString(),
                ),
              ],
            );
          }),
    );
  }
}

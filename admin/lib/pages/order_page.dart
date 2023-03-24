///   ณัฐชัย กัณฑเจตน์ 620510595
///   OrderPage
///   หน้าจอแสดงหน้าสถานะของออเดอร์ทั้งหมด

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:pak_admin/entities/cartinfo_entity.dart';
import 'package:pak_admin/theme/customtheme.dart';
import 'package:pak_admin/widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายการออเดอร์",
          style:
              TextStyle(fontWeight: FontWeight.w600, color: CoffeeColor.milk),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FirebaseAnimatedList(
            query: FirebaseDatabase.instance
                .ref('orderInfo/')
                .orderByChild('status'),
            itemBuilder: (context, snapshot, animation, index) {
              if (snapshot.child('menuList').value != null) {
                String data = jsonEncode(snapshot.child('menuList').value);
                Map<String, CartInfo> cartInfo = cartInfoFromJson(data);
                return OrderCardWidget(
                  cartInfo: cartInfo,
                  username: snapshot.child('username').value.toString(),
                  userId: snapshot.child('userId').value.toString(),
                  status: int.parse(snapshot.child('status').value.toString()),
                  orderId: snapshot.key.toString(),
                );
              } else {
                return const Center(
                  child: Text('ไม่มีออเดอร์'),
                );
              }
            }),
      ),
    );
  }
}

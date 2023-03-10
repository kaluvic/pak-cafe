import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:pak_user/entities/order_entity.dart';

class OrderService {
  final ref = FirebaseDatabase.instance.ref();

  Future<OrderList?> fetchOrderList(String uid) async {
    return await ref.child('order/$uid').once().then((event) {
      String json = jsonEncode(event.snapshot.value);
      OrderList? orderList = orderListFromJson(json);
      return orderList;
    });
  }
}
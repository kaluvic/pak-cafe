///   ณัฐชัย กัณฑเจตน์ 620510595
///   CartService
///   Feature สำหรับสร้างออเดอร์และข้อมูลออเดอร์ในดาต้าเบส

import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:pak_user/entities/cart_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CartService {
  Map<String, dynamic> cartItem = {};
  String userId = '';

  Future<Map<String, dynamic>> fetchCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storage = prefs.getString('cart') ?? '{}';
    return json.decode(storage);
  }

  Future<List<Item>> callCartAsList() async {
    Map<String, dynamic> cart = await fetchCart();
    List<Item> data = [];
    cart.forEach((key, value) {
      Item item = itemFromJson(value.toString());
      data.add(item);
    });
    return data;
  }

  void addToCart(Item item) async {
    cartItem = await fetchCart();
    if (cartItem.containsKey(item.itemId)) {
      cartItem.update(item.itemId, (value) => jsonEncode(item));
    } else {
      cartItem[item.itemId] = jsonEncode(item);
    }
    _saveCart();
  }

  void removeFromCart(String itemId) async {
    cartItem = await fetchCart();
    if (cartItem.containsKey(itemId)) {
      cartItem.remove(itemId);
    }
    _saveCart();
  }

  void _saveCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cart', json.encode(cartItem));
  }

  void removeCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cart');
  }

  void setOrder(String username, String userId, double totalPrice) async {
    var uuid = const Uuid();
    String cartListId = uuid.v4();
    DatabaseReference orderInfoRef =
        FirebaseDatabase.instance.ref("orderInfo/$cartListId");
    await orderInfoRef.set({
      'username': username,
      "status": 0,
      "userId": userId,
    });

    int number = 2;
    DatabaseReference orderNumRef =
        FirebaseDatabase.instance.ref("order/$userId");
    await orderNumRef.child("orderNumber").once().then((value) async {
      if (value.snapshot.value == null) {
        await orderNumRef.update({'orderNumber': number});
      } else {
        number = value.snapshot.value as int;
      }
    });
    await orderNumRef.update({'orderNumber': number + 1});
    DatabaseReference orderListRef =
        FirebaseDatabase.instance.ref("order/$userId/orderList/$number");
    await orderListRef.set({
      "orderId": cartListId,
      "status": 0,
      "time": DateFormat('d/M/y H:m').format(DateTime.now()),
      "totalPrice": totalPrice
    });

    setOrderInfo(cartListId);
    removeCart();
  }

  void setOrderInfo(String cartListId) async {
    var uuid = const Uuid();
    cartItem = await fetchCart();
    for (dynamic value in cartItem.values) {
      Item item = itemFromJson(value);
      String cartItemId = uuid.v4();
      DatabaseReference itemRef = FirebaseDatabase.instance
          .ref("orderInfo/$cartListId/menuList/$cartItemId");
      await itemRef.set({
        'count': item.count,
        'menuName': item.name,
        'note': item.note,
        'status': item.status,
        'toppings': item.toppings
      });
    }
  }

  void fetchOrderInfo() async {
    final ref = FirebaseDatabase.instance.ref();
    await ref.child('orderInfo').once().then((event) {
      String json = jsonEncode(event.snapshot.value);
    });
  }
}

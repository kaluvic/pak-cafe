import 'dart:convert';

import 'package:pak_user/entities/cart_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  Map<String, dynamic> cartItem = {};

  Future<Map<String, dynamic>> fetchCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storage = prefs.getString('cart') ?? '{}';
    return json.decode(storage);
  }

  Future<List<Item>> callCartAsList() async {
    Map<String, dynamic> cart = await fetchCart();
    List<Item> data = [];
    cart.forEach((key, value) {
      print(value);
      Item item = itemFromJson(value.toString());
      data.add(item);
    });
    return data;
  }

  void _printCart() {
    fetchCart().then((value) {
      print(value);
    });
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
    _printCart();
  }

  void removeCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cart');
  }
}

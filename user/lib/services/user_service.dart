import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:pak_user/entities/userlist_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<Map<String, UserList>> fetchUser() async {
    return await dbRef.child("user").once().then(
      (event) {
        String json = jsonEncode(event.snapshot.value);
        Map<String, UserList> userList = userListFromJson(json);
        return userList;
      },
    );
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final userInfo = await SharedPreferences.getInstance();
    Map<String, dynamic> user = {};
    String? userName = userInfo.getString('name');
    String? userId = userInfo.getString('userId');
    double? credit = userInfo.getDouble('credit');
    user.addAll({'name': userName, 'userId': userId, 'credit': credit});
    return user;
  }

  // Future<void> userCache() async {
  //   final userCache = await SharedPreferences.getInstance();
  //   print(userCache.getString('name'));
  // }

  Future<bool> isLogin() async {
    final user = await SharedPreferences.getInstance();
    if (user.getString('name') != null) {
      return true;
    }
    return false;
  }

  Future<void> setUserCache(String name, String userId, double credit) async {
    final user = await SharedPreferences.getInstance();

    await user.setString('userId', userId);
    await user.setString('name', name);
    await user.setDouble('credit', credit);
  }
}

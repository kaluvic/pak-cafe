import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:pak_user/entities/userlist_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

// fetch user infomation form firebase real-time database and put into object UserList.
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

  // get user infomation from UserList and storaged in cache.
  Future<Map<String, dynamic>> getUserInfo() async {
    final userInfo = await SharedPreferences.getInstance();
    Map<String, dynamic> user = {};
    String? userName = userInfo.getString('name');
    String? userId = userInfo.getString('userId');
    double? credit = userInfo.getDouble('credit');
    user.addAll({'name': userName, 'userId': userId, 'credit': credit});
    return user;
  }

  // update user credit that match the userId in both cache and database.
  Future<void> updateUserCredit(double credit, String userId) async {
    final user = await SharedPreferences.getInstance();
    Map<String, UserList> userList = await fetchUser();
    await user.setDouble('credit', credit);
    userList.forEach((key, value) {
      if (key == userId) {
        dbRef.child('user/$userId').update({'credit': credit});
      }
    });
  }

  // check if user is loggin before?
  Future<bool> isLogin() async {
    final user = await SharedPreferences.getInstance();
    if (user.getString('name') != null) {
      return true;
    }
    return false;
  }

  // set user information from database to cache.
  Future<void> setUserCache(String name, String userId, double credit) async {
    final user = await SharedPreferences.getInstance();

    await user.setString('userId', userId);
    await user.setString('name', name);
    await user.setDouble('credit', credit);
  }

  // clear user cache.
  Future<void> clearUserCache() async {
    final user = await SharedPreferences.getInstance();

    await user.remove('name');
    await user.remove('userId');
    await user.remove('credit');
  }
}

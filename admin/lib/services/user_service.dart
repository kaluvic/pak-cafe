import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:pak_admin/entities/userlist_entity.dart';

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

  Future<List<UserList>> fetchUserList() async {
    List<UserList> user = [];
    Map<String, UserList> userList = await fetchUser();
    userList.forEach((key, value) {
      user.add(value);
    });
    return user;
  }

  Future<void> updateUser(UserList user, double credit) async {
    return await dbRef.child("user").update({
      user.userId: {
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "credit": credit,
        "userId": user.userId
      }
    });
  }
}

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:pak_user/entities/userlist_entity.dart';

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
}

import 'dart:convert';

Map<String, UserList> userListFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, UserList>(k, UserList.fromJson(v)));

String userListToJson(Map<String, UserList> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class UserList {
  UserList({
    required this.password,
    required this.name,
    required this.credit,
    required this.userId,
    required this.email,
  });

  String password;
  String name;
  int credit;
  String userId;
  String email;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        password: json["password"],
        name: json["name"],
        credit: json["credit"],
        userId: json["userId"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "name": name,
        "credit": credit,
        "userId": userId,
        "email": email,
      };
}

import 'dart:convert';

Map<String, UserList> userListFromJson(String str) => Map.from(json.decode(str))
    .map((k, v) => MapEntry<String, UserList>(k, UserList.fromJson(v)));

String userListToJson(Map<String, UserList> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class UserList {
  UserList(
      {required this.credit,
      required this.email,
      required this.name,
      required this.password,
      required this.userId});

  double credit;
  String email;
  String name;
  String password;
  String userId;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
      credit: double.parse(json["credit"].toString()),
      email: json["email"],
      name: json["name"],
      password: json["password"],
      userId: json["userId"]);

  Map<String, dynamic> toJson() => {
        "credit": credit,
        "email": email,
        "name": name,
        "password": password,
        "userId": userId
      };
}

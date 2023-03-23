import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pak_user/entities/userlist_entity.dart';
import 'package:pak_user/pages/login.dart';
import 'package:pak_user/services/user_service.dart';
import 'package:uuid/uuid.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailForm = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late String _password;
  late String name;
  late String email;
  late String password;
  late String userId;
  var uuid = const Uuid();
  final dbRef = FirebaseDatabase.instance.ref();
  final userService = UserService();
  Map<String?, UserList> userList = {};
  bool isExist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            Container(
              margin: const EdgeInsets.only(
                  top: 0, left: 30, right: 30, bottom: 40),
              child: SafeArea(
                  child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/MyIcon.jpg'),
                  ),
                  FutureBuilder(
                      future: userService.fetchUser(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          userList = snapshot.data!;
                        }
                        return Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Name'),
                                  validator: (validate) {
                                    userList.forEach((key, value) {
                                      if (validate == value.name) {
                                        isExist = true;
                                      }
                                    });
                                    if (validate!.isEmpty) {
                                      return 'กรุณาใส่ชื่อ';
                                    } else if (validate.isNotEmpty && isExist) {
                                      return 'ชื่อนี้ถูกใช้งานแล้ว';
                                    }
                                    name = validate;
                                    isExist = false;
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  validator: (validate) {
                                    if (validate!.isEmpty) {
                                      return 'กรุณาใส่ Email';
                                    } else if (!_emailForm.hasMatch(validate)) {
                                      return 'Email ไม่ถูกต้อง';
                                    } else if (isExist) {
                                      return 'Email ถูกใช้งานแล้ว';
                                    }
                                    email = validate;
                                    isExist = false;
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
                                  validator: (validate) {
                                    if (validate!.isEmpty) {
                                      return 'กรุณาใส่รหัสผ่าน';
                                    } else if (validate.length < 8) {
                                      return 'รหัสผ่านน้อยกว่า 8 หลัก';
                                    }
                                    _password = validate;
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                      labelText: 'Confirm Password'),
                                  validator: (validate) {
                                    if (validate!.isEmpty) {
                                      return 'กรุณายืนยันรหัสผ่าน';
                                    } else if (validate != _password) {
                                      return 'รหัสผ่านไม่ตรงกัน';
                                    }
                                    password = validate;
                                    return null;
                                  },
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        userId = uuid.v4();
                                        if (_formKey.currentState!.validate()) {
                                          dbRef.child("user").update({
                                            userId: {
                                              "name": name,
                                              "email": email,
                                              "password": password,
                                              "credit": 0,
                                              "userId": userId
                                            }
                                          });
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ));
                                        }
                                      },
                                      child: const Text('สมัครสมาชิก')),
                                )
                              ],
                            ));
                      })
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

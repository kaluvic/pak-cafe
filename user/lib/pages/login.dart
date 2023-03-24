import 'package:flutter/material.dart';
import 'package:pak_user/entities/userlist_entity.dart';
import 'package:pak_user/pages/navigation.dart';
import 'package:pak_user/pages/register.dart';
import 'package:pak_user/services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailForm = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  late String email;
  late String password;
  final userService = UserService();
  late String returnText;

  Future<void> isLogin() async {
    if (await userService.isLogin()) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const NavigationPage(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    isLogin();
    return Scaffold(
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 40),
        child: Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/MyIcon.jpg'),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value!.isEmpty || !emailForm.hasMatch(value)) {
                          return 'Email ไม่ถูกต้อง';
                        }
                        email = value;
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 8) {
                          returnText = 'รหัสผ่านไม่ถูกต้อง';
                          return returnText;
                        }
                        password = value;
                        return null;
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 40, left: 20, right: 20, bottom: 20),
                      child: ElevatedButton(
                          onPressed: (() async {
                            Map<String, UserList> userList =
                                await userService.fetchUser();
                            userList.forEach((k, v) async {
                              if (_formKey.currentState!.validate()) {
                                if (v.email == email &&
                                    v.password == password) {
                                  await userService.setUserCache(
                                      v.name, v.userId, v.credit);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const NavigationPage()));
                                }
                                returnText = 'รหัสผ่านไม่ถูกต้อง';
                              }
                            });
                          }),
                          child: const Text('เข้าสู่ระบบ')),
                    )
                  ],
                )),
            TextButton(
                onPressed: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const RegisterPage()));
                }),
                child: const Text('สมัครสมาชิก'))
          ],
        ),
      )),
    );
  }
}

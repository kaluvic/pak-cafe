import 'package:flutter/material.dart';
import 'package:pak_user/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pak_user/pages/login.dart';
import 'package:pak_user/pages/navigation.dart';
import 'package:pak_user/services/user_service.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final userService = UserService();
  bool isLogin = await userService.isLogin();

  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLogin});
  bool isLogin;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLogin ? const NavigationPage() : const LoginPage(),
    );
  }
}

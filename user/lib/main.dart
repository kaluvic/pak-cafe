import 'package:flutter/material.dart';
import 'package:pak_user/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pak_user/pages/login.dart';
import 'package:pak_user/pages/navigation.dart';
import 'package:pak_user/services/user_service.dart';
import 'package:pak_user/theme/customtheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  bool isLogin = false;
  final userService = UserService();
  isLogin = await userService.isLogin();
  // userService.clearUserCache().then((value) async {
  //   isLogin = await userService.isLogin();
  //   log('Clear cache', name: 'system');
  // });
  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLogin});
  bool isLogin;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pak cafe',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.defaultTheme,
      home: isLogin ? const NavigationPage() : const LoginPage(),
    );
  }
}

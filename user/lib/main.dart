import 'package:flutter/material.dart';
import 'package:pak_user/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pak_user/pages/login.dart';
import 'package:pak_user/pages/navigation.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

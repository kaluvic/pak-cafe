import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pak_admin/firebase_options.dart';
import 'package:pak_admin/pages/navigation.dart';
import 'package:pak_admin/theme/customtheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pak cafe',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.defaultTheme,
      home: const NavigationPage(),
    );
  }
}

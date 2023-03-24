/// ธัชทร วงศ์ไชย 620510601

import 'package:flutter/material.dart';

/// CustomTheme
/// สำหรับกำหนด Theme ของแอพ
class CustomTheme {
  CustomTheme._();

  static ThemeData defaultTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        color: CoffeeColor.coffee,
      ),
      primarySwatch: CoffeeColor.coffee,
      textTheme: const TextTheme(button: TextStyle(fontSize: 18)));
}

/// CoffeeColor
/// กำหนดสีของแอพ
class CoffeeColor {
  static Color cream = const Color(0xFFD5CEA3);
  static Color milk = const Color(0xFFE5E5CB);

  static const MaterialColor darkcoffee = MaterialColor(
    0xFF1A120B,
    <int, Color>{
      50: Color(0xff17100a), //10%
      100: Color(0xff150e09), //20%
      200: Color(0xff120d08), //30%
      300: Color(0xff100b07), //40%
      400: Color(0xff0d0906), //50%
      500: Color(0xff0a0704), //60%
      600: Color(0xff080503), //70%
      700: Color(0xff050402), //80%
      800: Color(0xff030201), //90%
      900: Color(0xff000000), //100%
    },
  );
  static const MaterialColor coffee = MaterialColor(
    0xFF3C2A21,
    <int, Color>{
      50: Color(0xff36261e), //10%
      100: Color(0xff30221a), //20%
      200: Color(0xff2a1d17), //30%
      300: Color(0xff241914), //40%
      400: Color(0xff1e1511), //50%
      500: Color(0xff18110d), //60%
      600: Color(0xff120d0a), //70%
      700: Color(0xff0c0807), //80%
      800: Color(0xff060403), //90%
      900: Color(0xff000000), //100%
    },
  );
}

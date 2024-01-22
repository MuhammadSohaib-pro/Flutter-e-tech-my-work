import 'package:flutter/material.dart';

class ThemeColors {
  static const mainColor = Color(0xff1B1C1E);
  static const bgColor = Color(0xffFFFFFF);
  static var lightBgColor = const Color(0xffFFFFFF).withOpacity(.2);
  static const black1 = Color(0xff000000);
  static const grey1 = Color(0xFF858585);
  static const grey2 = Color(0xFF85898C);
  static const grey3 = Color(0xFF909090);
  static const grey4 = Color(0xFF464950);
  static const grey5 = Color(0xffEFF2F1);
  static const grey6 = Color(0xFF414141);
  static const darkGrey = Color(0xFF363340);
  static const yellow = Color(0xFFF0A215);
  static const green = Color(0xFF18B35B);
  static const red = Color(0xFFDF0815);
  static const mainDark = Color(0xFF720404);
  static var fillColor = Colors.white.withOpacity(0.029999999329447746);
  static var borderColor = Colors.white.withOpacity(0.09000000357627869);
  static var bgLight2Color = Colors.white.withOpacity(0.10000000149011612);
}

class Palette {
  static const MaterialColor palette1 = MaterialColor(
    _palette1PrimaryValue,
    <int, Color>{
      50: Color(0xFFE4E4E4),
      100: Color(0xFFBBBBBC),
      200: Color(0xFF8D8E8F),
      300: Color(0xFF5F6062),
      400: Color(0xFF3D3E40),
      500: Color(_palette1PrimaryValue),
      600: Color(0xFF18191A),
      700: Color(0xFF141416),
      800: Color(0xFF101112),
      900: Color(0xFF08090A),
    },
  );

  static const int _palette1PrimaryValue = 0xff1B1C1E;
}

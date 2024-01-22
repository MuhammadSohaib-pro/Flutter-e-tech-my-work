import 'package:flutter/material.dart';

class ThemeColors {
  static const mainColor = Color(0xFF5429ff);
  static const bgColor = Color(0xffFFFFFF);
  static const black1 = Color(0xff000000);
  static const grey1 = Color(0xFF344054);
  static const grey2 = Color(0xFF667085);
  static const grey3 = Color(0xFFF5F5F5);
  static const grey4 = Color(0xFF393640);
  static const grey5 = Color(0xffEFF2F1);
  static const grey6 = Color(0xFFD9D9D9);
  static const darkGrey = Color(0xFF363340);
  static const yellow = Color(0xFFF0A215);
  static const green = Color(0xFF27B43E);
  static const red = Color(0xFFE61010);
  static const mainDark = Color(0xFF0D1632);
  static const fillColor = Color(0xFFF6F6F6);
}

class Palette {
  static const MaterialColor palette1 = MaterialColor(
    _palette1PrimaryValue,
    <int, Color>{
  50: Color(0xFFEAE5FF),
  100: Color(0xFFCCBFFF),
  200: Color(0xFFAA94FF),
  300: Color(0xFF8769FF),
  400: Color(0xFF6E49FF),
  500: Color(_palette1PrimaryValue),
  600: Color(0xFF4D24FF),
  700: Color(0xFF431FFF),
  800: Color(0xFF3A19FF),
  900: Color(0xFF290FFF),
    },
  );

  static const int _palette1PrimaryValue = 0xFF5429ff;
}

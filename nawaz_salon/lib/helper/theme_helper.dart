import 'package:flutter/material.dart';

class ThemeColors {
  static const mainColor = Color(0xFF2A2733);
  static const bgColor = Color(0xffF9F9F9);
  static const black1 = Color(0xff1A1D1E);
  static const grey1 = Color(0xFF7D7D7D);
  static const grey2 = Color(0xFFE0E0E0);
  static const grey3 = Color(0xFF848797);
  static const grey4 = Color(0xFF393640);
  static const grey5 = Color(0xffEFF2F1);
  static const darkGrey = Color(0xFF363340);
  static const yellow = Color(0xFFF0A215);
  static const red = Color(0xFFEA0000);
  static const fillColor = Color(0xFF35323F);
}

class Palette {
  static const MaterialColor palette1 = MaterialColor(
    _palette1PrimaryValue,
    <int, Color>{
      50: Color(0xFFE5E5E7),
      100: Color(0xFFBFBEC2),
      200: Color(0xFF959399),
      300: Color(0xFF6A6870),
      400: Color(0xFF4A4752),
      500: Color(_palette1PrimaryValue),
      600: Color(0xFF25232E),
      700: Color(0xFF1F1D27),
      800: Color(0xFF191720),
      900: Color(0xFF0f0e14),
    },
  );

  static const int _palette1PrimaryValue = 0xFF2A2733;
}

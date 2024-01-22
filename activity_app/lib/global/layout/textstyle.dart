
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:flutter/material.dart';

class MyTextStyles {
  static TextStyle myTextStylelight = TextStyle(
    color: Color(0xFF9F9F9F),
    fontSize: SizeConfig.textMultiplier * 1.8,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    letterSpacing: -0.30,
  );
  static TextStyle myTextStylelightsize(double fontSize,) {
    return TextStyle(
    color:Color(0xFF9F9F9F),
    fontSize:fontSize ,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    letterSpacing: -0.30,);
    }
  static TextStyle boldTextStyle = TextStyle(
    color: Colors.black,
    fontSize: SizeConfig.textMultiplier * 2.5,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    height: 0,
    letterSpacing: -0.30,
  );


  static TextStyle darkTextStyle({Color? color}) {
    return TextStyle(
      color: color ?? Colors.white,
      // Use the provided color or default to white
      fontSize: SizeConfig.textMultiplier * 2,
      fontFamily: 'Inter',
      fontWeight: FontWeight.w500,
      height: 0,
      letterSpacing: -0.30,
    );
  }

  static TextStyle myTextStyleappbar = TextStyle(
    color: Color(0xFF2538E8),
    fontSize: SizeConfig.textMultiplier * 1.8,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    height: 0,
    letterSpacing: -0.30,
  );
  static TextStyle interTextstyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      height: 0,
    );
  }
  static TextStyle latoTextstyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontFamily: 'Lato',
      fontWeight: fontWeight,
      height: 0,
    );
  }
  static TextStyle latoTextstylecolor(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      color:color,// Colors.black,
      fontSize: fontSize,
      fontFamily: 'Lato',
      fontWeight: fontWeight,
      height: 0,
    );
  }

  static TextStyle poppinsTextstylecolor(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      color:color,// Colors.black,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      height: 0,
    );
  }
  static TextStyle interTextstylelight(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontFamily: 'Inter',
      fontWeight: fontWeight,
      height: 0,
    );
  }
  static TextStyle MuktaTextstyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontFamily: 'Mukta',
      fontWeight: fontWeight,
      height: 0,
    );
  }
}
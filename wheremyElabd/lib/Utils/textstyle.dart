import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/appcolor.dart';

class MyTextStyles {
  static TextStyle maintextstyle(double fontSize) {
    return TextStyle(
      color:AppColors.mainapptextColor,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      height: 0.94,
      letterSpacing: -0.60,
    );
  }
  static TextStyle namestyle(double fontSize) {
    return TextStyle(
      color:AppColors.name,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      height: 0.94,
      letterSpacing: -0.60,
    );
  }


  static TextStyle longtextstyle(double fontSize) {
    return TextStyle(
      color:AppColors.mainapptextColor,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      height: 1.2,
      letterSpacing: -0.60,
    );
  }

  static TextStyle storagetextstyle(double fontSize) {
    return TextStyle(
      color: AppColors.black,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      height: 0.01,
      letterSpacing: -1.08,
    );
  }
  static TextStyle storagetextstylesubtitle(double fontSize) {
    return TextStyle(
      color:AppColors.storagetextstylesubtitle,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      height: 0.14,
      letterSpacing: -0.30,
    );
  }
  static TextStyle hinttextfield(double fontSize) {
  return TextStyle(
  color: AppColors.hinttetfield,
  fontSize: fontSize,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w400,
  height: 0.06,
  letterSpacing: -0.48,
  );}

  static const TextStyle appbartextstyle =TextStyle(
  color: AppColors.mainapptextColor,
  fontSize: 20,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w700,
  height: 0.10,
  letterSpacing: -0.54,
  );

  static const TextStyle settingsblacklit =TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: AppColors.black,
  );
  static const TextStyle settingsRedlit =TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.red,
  );
  static TextStyle settingsGrey(double fontSize) {
  return TextStyle(
  color: AppColors.settingsgrey,
  fontSize: fontSize,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w500,
  height: 0,
  letterSpacing: 0.50,
  );}


// static const TextStyle anotherCustomTextStyle = TextStyle(
//   // Define another custom text style here
// );
}

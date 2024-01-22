import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:event_manager_app/helper/mySize.dart';
import 'package:event_manager_app/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CommonFunctions {
  static String? validateTextField(value) {
    if (value == null || value.isEmpty) {
      return "Field is Requireed";
    } else {
      return null;
    }
  }

  static void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static flushBarErrorMessage(String msg, BuildContext context) {
    MySize().init(context);
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: msg,
        barBlur: 2,
        messageColor: ThemeColors.bgColor,
        messageSize: MySize.size12,
        backgroundColor: ThemeColors.red,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        duration: const Duration(seconds: 3),
        borderWidth: 0.1,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: MySize.size26,
          color: ThemeColors.bgColor,
        ),
        borderRadius: BorderRadius.circular(5),
      )..show(context),
    );
  }

  static flushBarSuccessMessage(String msg, BuildContext context) {
    MySize().init(context);
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        message: msg,
        barBlur: 2,
        messageColor: ThemeColors.bgColor,
        messageSize: MySize.size12,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        duration: const Duration(seconds: 3),
        borderWidth: 0.1,
        positionOffset: 20,
        icon: Icon(
          Icons.check_circle_rounded,
          size: MySize.size26,
          color: ThemeColors.bgColor,
        ),
        borderRadius: BorderRadius.circular(5),
      )..show(context),
    );
  }
}

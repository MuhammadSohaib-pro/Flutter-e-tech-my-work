import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CommonFunctions {
  static String? validateTextField(value) {
    if (value == null || value.isEmpty) {
      return "Field is Required";
    } else {
      return null;
    }
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

  static Route createRoute(Widget nextScreen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

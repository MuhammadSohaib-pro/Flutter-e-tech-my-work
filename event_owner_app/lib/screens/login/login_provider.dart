// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/screens/drawer/drawer_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:event_owner_app/helper/common_functions.dart';

class LoginProvider with ChangeNotifier {
  bool _obsecureText = true;

  bool get obsecureText => _obsecureText;

  setObsecureText(bool value) {
    _obsecureText = value;
    notifyListeners();
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  forgotPassword(String email, BuildContext context) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        changeShowLoaderValue(false);
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Reset Email Sent Successfully", context);
      });
    } on FirebaseAuthException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .then((value) {
        changeShowLoaderValue(false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DrawerView()),
          (route) => false,
        );
        CommonFunctions.flushBarSuccessMessage("Login Successfully", context);
      });
    } on FirebaseAuthException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }
}

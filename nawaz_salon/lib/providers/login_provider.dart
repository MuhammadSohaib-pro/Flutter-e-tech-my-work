import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  bool obscurePassword = true;


  setObsecurePassword() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}

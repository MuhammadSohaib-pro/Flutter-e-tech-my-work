// ignore_for_file: invalid_use_of_protected_member

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obsecurePassword = true;
  bool _loading = false;

  bool get obsecurePassword => _obsecurePassword;
  bool get loading => _loading;

  changeObsecureValue() {
    _obsecurePassword = !_obsecurePassword;
    notifyListeners();
  }

  changeLoadingValue(bool value) {
    _loading = value;
    notifyListeners();
  }

  signUpWithFirebase() async {
    changeLoadingValue(true);
    final firebaseInstance = FirebaseAuth.instance;
    firebaseInstance
        .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then(
      (value) async {
        try {
          await firebaseInstance.currentUser!
              .updateDisplayName(fullNameController.text);
        } catch (e) {
          print("User not sign in");
        }
        changeLoadingValue(false);
        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
      },
    ).onError(
      (error, stackTrace) {
        changeLoadingValue(false);
      },
    );
  }
}

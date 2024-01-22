// ignore_for_file: invalid_use_of_protected_member

import 'package:chatbot/views/chat/chat_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
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

  signInWithFirebase(BuildContext context) async {
    changeLoadingValue(true);
    final firebaseInstance = FirebaseAuth.instance;
    firebaseInstance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then(
      (value) async {
        changeLoadingValue(false);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatView(),
          ),
        );
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

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/helper/common_functions.dart';
import 'package:event_app/screens/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpProvider with ChangeNotifier {
  bool _obsecureText1 = true;

  bool get obsecureText1 => _obsecureText1;

  setObsecureText1(bool value) {
    _obsecureText1 = value;
    notifyListeners();
  }

  bool _obsecureText2 = true;

  bool get obsecureText2 => _obsecureText2;

  setObsecureText2(bool value) {
    _obsecureText2 = value;
    notifyListeners();
  }

  bool _showLoader = false;

  bool get showLoader => _showLoader;

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  signUpWithEmailPassword(String fullname, String email, String contact,
      String password, BuildContext context) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      )
          .then((value) {
        FirebaseAuth auth = FirebaseAuth.instance;
        FirebaseFirestore.instance
            .collection("users")
            .doc(auth.currentUser!.uid)
            .set(
          {
            "id": auth.currentUser!.uid,
            "fullname": fullname,
            "email": email.trim(),
            "contact": contact,
            "password": password,
          },
        );
      }).then((value) {
        changeShowLoaderValue(false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBarView()),
          (route) => false,
        );
        CommonFunctions.flushBarSuccessMessage("Signup Successfull", context);
      });
    } on FirebaseAuthException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }
}

import 'dart:io';

import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  User? get user => _user;

  Future<bool> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _user = userCredential.user;
      notifyListeners();
      return true;
    } catch (e) {
      getFlushBar(context, title: 'Error: $e');
      return false;
    }
  }

  Future<void> resetPasswor(
      {required BuildContext context, String? email}) async {
    SmartDialog.showLoading();
    try {
      _auth.sendPasswordResetEmail(email: email!).then((value) {
        SmartDialog.dismiss();
        getFlushBar(context,
            title: 'We have sent password reset email', color: primaryColor);
      }).onError((error, stackTrace) {
        SmartDialog.dismiss();
        getFlushBar(context, title: error.toString());
      });
    } catch (e) {
      getFlushBar(context, title: 'Error $e');
      SmartDialog.dismiss();
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
      return true;
    } catch (e) {
      // Handle sign-out errors
      debugPrint(e.toString());
      return false;
    }
  }
}

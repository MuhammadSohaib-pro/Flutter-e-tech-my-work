import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServiceProvider with ChangeNotifier {
  // final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
  // UserModel? _userFromFirebase(auth.User? user) {
  //   if (user == null) {
  //     return null;
  //   } else {
  //     return UserModel(user.uid, user.email);
  //   }
  // }
  // Stream<UserModel?>? get user {
  //   return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  // }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  User? get user => _user;
  // Future<bool> signUp(String email, String password) async {
  //   try {
  //     final UserCredential userCredential =
  //         await _auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     _user = userCredential.user;
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     // Handle sign-up errors
  //     print(e);
  //     return false;
  //   }
  // }



  Future<bool> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // String fullName = ""; // Set the user's full name
      // String userName = ""; // Set the user's username
      // String id = FirebaseAuth.instance.currentUser!.uid;

      _user = userCredential.user;

      // await storedUserInFirebase(fullName, userName, email, password, id);
      notifyListeners();
      return true; // Sign-in successful
    } catch (e) {
      print("Sign-in error: $e");
      return false; // Sign-in failed
    }
  }

  Future<void> storedUserInFirebase(String fullName, String userName,
      String email, String password, String id) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(_user!.uid);
      await userDocRef.set({
        'fullName': fullName,
        'userName': userName,
        'email': email,
        'password': password,
      });
      print('User data stored in Firestore successfully');
    } catch (e) {
      print('Error storing user data in Firestore: $e');
    }
  }

  Future<void> updateStoredUserInFirebase(
      String? fullName, String? userName, String? password) async {
    try {
      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(_user!.uid);
      await userDocRef.update({
        'fullName': fullName,
        'userName': userName,
        'password': password,
      });
      print('User data stored in Firestore successfully');
    } catch (e) {
      print('Error storing user data in Firestore: $e');
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
      print(e);
      return false;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(msg: "Password reset email sent");
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  // void storedUserInFirebase(String fullName, String userName, String email) {
  //   CollectionReference? collection =
  //       FirebaseFirestore.instance.collection("users");
  //   UserModel userModel = UserModel(uuid.v1(), email, userName, fullName);
  //   collection.add(userModel);
  // }

  // Future<UserModel?> signInWithEmailAndPassword(
  //     String email, String password) async {}
  //
  // Future<UserModel?> createUserWithEmailAndPassword(
  //     String email, String password) async {}
  //
  // Future<void> signOut() async {}
}

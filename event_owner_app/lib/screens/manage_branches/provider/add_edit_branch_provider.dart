// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_owner_app/helper/common_functions.dart';
import 'package:event_owner_app/model/branch_model.dart';
import 'package:flutter/material.dart';

class AddEditBranchProvider with ChangeNotifier {
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

  String _imageLink = "";

  String get imageLink => _imageLink;

  setImageLink(String value) {
    _imageLink = value;
    notifyListeners();
  }



  bool _showLoader = false;

  bool get showLoader => _showLoader;

  changeShowLoaderValue(bool value) {
    _showLoader = value;
    notifyListeners();
  }

  BranchModel obj = BranchModel();

  Future<void> addNewBranch({
    required String managerName,
    required String managerRefId,
    required String email,
    required String name,
    required String address,
    required String phone,
    required String password,
    required String ref,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(ref)
          .collection("branches")
          .doc()
          .set(
        {
          "image": imageLink,
          "managerDocId": managerRefId,
          "managerName": managerName,
          "email": email,
          "name": name,
          "address": address,
          "contact": phone,
          "password": password,
          "activeOrDeactive": "Active"
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        setObsecureText1(true);
        setObsecureText2(true);
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Branch Added Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> editNewBranch({
    required String managerName,
    required String email,
    required String address,
    required String name,
    required String managerRefId,
    required String ref,
    required String addRef,
    required String phone,
    required String password,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(addRef)
          .collection("branches")
          .doc(ref)
          .update(
        {
          "managerDocId": managerRefId,
          "managerName": managerName,
          "email": email,
          "name": name,
          "address": address,
          "contact": phone,
          "password": password,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        setObsecureText1(true);
        setObsecureText2(true);
        Navigator.pop(context);
        CommonFunctions.flushBarSuccessMessage(
            "Branch Updated Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> activeDeactiveBranch({
    required String activeDeactive,
    required String addRef,
    required String ref,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(addRef)
          .collection("branches")
          .doc(ref)
          .update(
        {
          "activeOrDeactive": activeDeactive,
        },
      ).then((value) {
        changeShowLoaderValue(false);
        Navigator.pop(context);
        setImageLink("");
        CommonFunctions.flushBarSuccessMessage(
            "Status Change Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }

  Future<void> deleteBranch({
    required String addRef,
    required String ref,
    required BuildContext context,
  }) async {
    try {
      changeShowLoaderValue(true);
      await FirebaseFirestore.instance
          .collection("restaurants")
          .doc(addRef)
          .collection("branches")
          .doc(ref)
          .delete()
          .then((value) {
        changeShowLoaderValue(false);
        setImageLink("");
        Navigator.popUntil(context, (route) => route.isFirst);
        CommonFunctions.flushBarSuccessMessage(
            "Branch Deleted Successfully", context);
      });
    } on FirebaseException catch (e) {
      changeShowLoaderValue(false);
      CommonFunctions.flushBarErrorMessage(e.code, context);
    }
  }
}

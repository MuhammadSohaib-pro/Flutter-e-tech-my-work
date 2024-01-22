import 'package:flutter/material.dart';

class CommonFunctions {
  static String? validateTextField(value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return "Field is Required";
    } else {
      return null;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonFunctions {
  static String? validateTextField(value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.fieldRequired.toString();
    } else {
      return null;
    }
  }
}

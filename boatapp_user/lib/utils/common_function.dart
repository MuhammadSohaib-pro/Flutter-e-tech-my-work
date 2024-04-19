import 'package:boat_app/languages/LocaleString.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CommonFunctions {
  static String? validateTextField(value, BuildContext context,String type) {
    if(type == 'email'){
      if (value == null || value.isEmpty) {
        return AppLocale.enterYourEmail.getString(context);
      } else if (value.isNotEmpty) {
        String emailOfuser1 = value.toString();
        // final RegExp _emailRegExp = RegExp(
        //   r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
        // );
        String pattern = r'\w+@\w+\.\w+';
        if (RegExp(pattern).hasMatch(emailOfuser1) == false) {
          return AppLocale.enterValidEmail.getString(context);
        }
      }
      return null;
    }
    else if(type == 'password'){
      if (value == null || value.isEmpty) {
        return AppLocale.enterPassword.getString(context);
      } else if(value.toString().length < 6) {
        return AppLocale.enterLongPassword.getString(context);
      }

    }
    else if(type == 'name'){
      if (value == null || value.isEmpty) {
        return AppLocale.enterYourName.getString(context);
      } else {
        return null;
      }
    }
    else if(type == 'phone'){
      if (value == null || value.isEmpty) {
        return AppLocale.enterPhone.getString(context);
      } else {
        return null;
      }
    }

  }
static void loginFailedDialog(BuildContext context, String error, VoidCallback onTap){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(AppLocale.signInFailed.getString(context)),
        content: Text(error),
        actions: [
          TextButton(
            child:  Text(AppLocale.ok.getString(context)),
            onPressed: onTap,
          ),
        ],
      );
    },
  );
}

}
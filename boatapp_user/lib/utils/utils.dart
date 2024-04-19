import 'dart:io';

import 'package:boat_app/custom_widgets/app_button.dart';
import 'package:boat_app/utils/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../languages/LocaleString.dart';


class Utils{
   static launchSocialApps(String url) async {
    var encoded = Uri.parse(url);
    if (await canLaunchUrl(encoded)) {
      launchUrl(encoded,

          mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static toastMessage(String message){
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          content: Text(message, style: TextStyle(color: Colors.white),),
        )
    );
  }

  static Future<bool> checkInternetConnection() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }

  static String? validateEmail(String value) {
    // The regular expression pattern to check for email format
    String pattern = r'^([a-zA-Z0-9_\.-]+)@([\da-zA-Z\.-]+)\.([a-zA-Z\.]{2,6})$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static void showImageDialog(BuildContext context, ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('No internet connection'),
        content:
        const Text('Please check your internet connection and try again.'),
        actions: [
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
  static Future<bool> checkNetwork() async {
    bool isConnected = false;
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
    }
    return isConnected;
  }
  static void authErrorSnackbar(BuildContext context, String title, String message) {
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
         content: Text(message),
         backgroundColor: Colors.black.withOpacity(0.6),
         // margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
         // elevation: 20,
         behavior: SnackBarBehavior.fixed,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(10),
         ),
         action: SnackBarAction(
           label: 'Close',
           onPressed: () {
             // Add any action on pressing the close button
           },
         ),
       ),
     );
   }
  static void showDeletedDialog(BuildContext context) {
     showDialog(
       context: context,
       builder: (BuildContext context) {
         return AlertDialog(
           title: Text(AppLocale.accountDeleted.getString(context)),
           content: Text(AppLocale.yourAccountHasDeleted.getString(context)),
           actions: [
             AppButton(
               width: width(context)* 0.35,
               height: height(context)* 0.04,
               textSize: 10,
               onPressed: () {
                 launchEmail('mailto:sohib.balkhy@gmail.com');
                 // Perform the action when the "Contact Admin" button is pressed
                 // Add your logic for contacting the admin here
                 Navigator.of(context).pop(); // Close the dialog
               }, text: AppLocale.contactAdmin.getString(context),

             ),
           ],
         );
       },
     );
   }
   static launchEmail(String url) async {
     var encoded = Uri.parse(url);
     if (await canLaunchUrl(encoded)) {
       launchUrl(encoded,

           mode: LaunchMode.externalApplication);
     } else {
       throw 'Could not launch $url';
     }
   }

}


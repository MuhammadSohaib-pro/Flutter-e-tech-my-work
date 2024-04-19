import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';

import '../languages/LocaleString.dart';
import '../provider/loading_provider/loading_provider.dart';
import '../view/auth/signin/loginscreen.dart';
import 'colors.dart';
import 'image_paths.dart';

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:  Text(AppLocale.noInternet.getString(context)),
      content:
       Text(AppLocale.pleaseCheckInternetAgain.getString(context)),
      actions: [
        ElevatedButton(
          child:  Text(AppLocale.ok.getString(context)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

showDialogGuest(BuildContext context){
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: white1,
        title:  Text(AppLocale.registerPlease.getString(context), style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
        content:  Text(AppLocale.kindlyRegisterToUseFeature.getString(context)),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Utils.launchSocialApps('mailto:taimoor00777@gmail.com');

              final loadingProvider =
              Provider.of<LoadingProvider>(context, listen: false);
              loadingProvider.loginLoading(false);
              // Navigator.of(context).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginView()));
            },
            child: Text(AppLocale.goToLogin.getString(context)),
          ),
          TextButton(
            onPressed: () {
              final loadingProvider =
              Provider.of<LoadingProvider>(context, listen: false);
              loadingProvider.loginLoading(false);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text(AppLocale.close.getString(context)),
          ),
        ],
      );
    },
  );
}

// void showImageDialog2(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (context) {
//       // Start a timer for 3 seconds
//       Timer(Duration(seconds: 3), () {
//         Navigator.pop(context); // Close the dialog after 3 seconds
//       });
//
//       return AlertDialog(
//         title: const Text('No internet connection'),
//         content: const Text('Please check your internet connection and try again.'),
//         actions: [
//           ElevatedButton(
//             child: const Text('OK'),
//             onPressed: () {
//               // Manually pop the dialog if the user clicks "OK" before the timer elapses
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }


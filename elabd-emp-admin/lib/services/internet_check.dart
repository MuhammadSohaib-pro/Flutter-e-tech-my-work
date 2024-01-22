import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../helper/import_helper.dart';

/// internet check
Future<bool> checkInternetConnection() async {
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

/// show Dialog
Future showNoInternetDialog(BuildContext context) async {
  showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            "No Internet",
            style: TextStyle(color: primaryColor, fontSize: 16),
          ),
          content: Column(
            children: [
              SizedBox(
                height: MySize.size10,
              ),
              Image.asset(
                AppIcons.no_connection,
                height: MySize.size50,
                width: MySize.size50,
              ),
              SizedBox(
                height: MySize.size10,
              ),
              const Text('Please Connect your Internet and try again'),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK')),
          ],
        );
      });
}

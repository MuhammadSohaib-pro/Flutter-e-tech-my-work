import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoSellSdkFlutter.configureApp(
    bundleId: Platform.isAndroid ? "ANDROID-PACKAGE-NAME" : "IOS-APP-ID",
    lang: "en",
    productionSecretKey:
        Platform.isAndroid ? "Android-Live-KEY" : "iOS-Live-KEY",
    sandBoxSecretKey:
        Platform.isAndroid ? "Android-SANDBOX-KEY" : "iOS-SANDBOX-KEY",
  );
  // // BEARER (stripe public key)
  //   Stripe.merchantIdentifier = 'merchant.com.elabdtech.practiceforpaymenygateway';
  // Stripe.publishableKey =
  //     "pk_test_51MgPVSFirPYpsqNHjbcjqWeyfpvpJMuvqIATOvrDPdkewBbQOjzSEcZZt7ThXwW6jq3CbPiAA0d5LbR3765MPacr00VNQbe1N2";
  // await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xff6058F7),
          secondary: Color(0xff6058F7),
        ),
        primaryColor: Colors.white,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(elevation: 1),
      ),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(),
    );
  }
}

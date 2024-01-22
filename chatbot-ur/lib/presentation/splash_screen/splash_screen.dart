import 'dart:async';

import 'package:chatbot/presentation/Auth/sign_in_screens.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      Navigator.pushAndRemoveUntil(
          NavigatorService.navigatorKey.currentContext!,
          MaterialPageRoute(builder: (context) => SignInScreens()),
          (route) => false);
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFrame,
                height: 50.adaptSize,
                width: 50.adaptSize,
              ),
              SizedBox(height: 11.v),
              Text(
                "lbl_chat_bot_ur".tr,
                style: CustomTextStyles.titleMediumInter_2,
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:event_manager_app/helper/constant.dart';
import 'package:event_manager_app/helper/mySize.dart';
import 'package:event_manager_app/helper/theme_helper.dart';
import 'package:event_manager_app/screens/login/login_view.dart';
import 'package:event_manager_app/screens/onboarding/onboarding_one_view.dart';
import 'package:event_manager_app/widgets/curve_clipper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? onbaordingFlag = prefs.getBool('onboardingWatched');
        print("onboardingWatched::: $onbaordingFlag");
        if (onbaordingFlag == null || onbaordingFlag == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingView1(),
            ),
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginView()),
            (route) => false,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: MySize.screenHeight / 2,
                  width: MySize.safeWidth,
                  decoration: const BoxDecoration(
                    color: ThemeColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MySize.size220,
            width: MySize.size220,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgLogo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

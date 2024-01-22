import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/Screens/login/login_view.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.bgColor,
      body: SafeArea(
        child: Center(
          child: SvgPicture.asset(
            imgLogo,
            semanticsLabel: 'Nawaz Saloon Logo',
          ),
        ),
      ),
    );
  }
}

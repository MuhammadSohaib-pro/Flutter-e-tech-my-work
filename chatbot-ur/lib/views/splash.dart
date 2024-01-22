import 'dart:async';

import 'package:chatbot/constants/images.dart';
import 'package:chatbot/constants/sizeconf.dart';
import 'package:chatbot/views/login.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginPage()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Container(
        height: MySize.screenHeight,
        width: MySize.screenWidth,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logo,
              width: MySize.size50,
              height: MySize.size50,
            ),
            Image.asset(
              logoname,
              width: MySize.size96,
              height: MySize.size19,
            )
          ],
        ),
      ),
    );
  }
}

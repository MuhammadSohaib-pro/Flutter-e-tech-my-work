import 'package:chatbot/helper/constant.dart';
import 'package:chatbot/helper/mySize.dart';
import 'package:chatbot/helper/theme_helper.dart';
import 'package:chatbot/views/chat/chat_view.dart';
import 'package:chatbot/views/login/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        FirebaseAuth.instance.idTokenChanges().listen((User? user) {
          if (user == null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ChatView(),
              ),
            );
          }
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MySize.size120,
            height: MySize.size90,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MySize.size50,
                  height: MySize.size50,
                  child: SvgPicture.asset(icSplash),
                ),
                SizedBox(height: MySize.size12),
                Text(
                  'Chat Bot UR',
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/login/login_view.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginRegisterView extends StatefulWidget {
  const LoginRegisterView({super.key});

  @override
  State<LoginRegisterView> createState() => _LoginRegisterViewState();
}

class _LoginRegisterViewState extends State<LoginRegisterView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MySize.safeWidth,
              height: MySize.safeHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Color(0xFF1D242D), Color(0xFF1B1C1E)],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset(icLogoBgRectangle),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      icLogoBg,
                      color: ThemeColors.bgColor.withOpacity(.1),
                    ),
                    SvgPicture.asset(icLogoFront),
                  ],
                ),
                SizedBox(height: MySize.size50),
                Padding(
                  padding: Spacing.horizontal(MySize.size25),
                  child: CustomSocialButton(
                    text: "Continue With Google",
                    onPressed: () {},
                    image: icGoogle,
                    backgroundColor: ThemeColors.fillColor,
                    borderColor: ThemeColors.borderColor,
                    radius: 30,
                    textColor: ThemeColors.bgColor,
                  ),
                ),
                SizedBox(height: MySize.size15),
                Padding(
                  padding: Spacing.horizontal(MySize.size25),
                  child: CustomSocialButton(
                    text: "Continue With Apple",
                    onPressed: () {},
                    image: icApple,
                    backgroundColor: ThemeColors.fillColor,
                    borderColor: ThemeColors.borderColor,
                    radius: 30,
                    textColor: ThemeColors.bgColor,
                  ),
                ),
                SizedBox(height: MySize.size15),
                Padding(
                  padding: Spacing.horizontal(MySize.size25),
                  child: CustomSocialButton(
                    text: "Sign In With Email",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    image: icEnvelope,
                    backgroundColor: ThemeColors.green,
                    borderColor: const Color(0x3DFFCD3B),
                    radius: 30,
                    textColor: ThemeColors.mainColor,
                  ),
                ),
                SizedBox(height: MySize.size20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don’t have an account',
                      style: TextStyle(
                        color: ThemeColors.grey4,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: ThemeColors.green,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                          decorationColor: ThemeColors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please read Our',
                      style: TextStyle(
                        color: ThemeColors.grey4,
                        fontSize: MySize.size10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Terms&Conditions',
                        style: TextStyle(
                          color: ThemeColors.green,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                          decorationColor: ThemeColors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MySize.size15),
              ],
            )
          ],
        ),
      ),
    );
  }
}

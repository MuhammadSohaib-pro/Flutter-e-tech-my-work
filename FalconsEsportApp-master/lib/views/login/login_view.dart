// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:falconsesportsapp/helper/common_functions.dart';
import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/bottom_nav_bar/bottom_nav_bar_view.dart';
import 'package:falconsesportsapp/views/signup/signup_view.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:falconsesportsapp/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignUpView(),
                ),
              );
            },
            child: Text(
              'Sign Up',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: ThemeColors.green,
                fontSize: MySize.size12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    icLogoBg,
                    color: ThemeColors.bgColor.withOpacity(.1),
                    height: MySize.size115,
                    width: MySize.size95,
                  ),
                  SvgPicture.asset(
                    icLogoFront,
                    height: MySize.size80,
                    width: MySize.size65,
                  ),
                ],
              ),
              SizedBox(height: MySize.size20),
              Text(
                'Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.bgColor,
                  fontSize: MySize.size24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MySize.size5),
              Text(
                'Enter you Registered Email Password to Sign In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.grey4,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MySize.size35),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: CustomTextField13(
                  controller: emailController,
                  prefixIcon: Padding(
                    padding: Spacing.all(MySize.size12),
                    child: SvgPicture.asset(
                      icEnvelope,
                      color: const Color(0xFFFFFFff).withOpacity(.2),
                    ),
                  ),
                  hintText: "Email",
                  radius: 30,
                  fillColor: ThemeColors.fillColor,
                  keyboardType: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: CustomTextField13(
                  controller: passwordController,
                  prefixIcon: Padding(
                    padding: Spacing.all(MySize.size12),
                    child: SvgPicture.asset(
                      icLock,
                    ),
                  ),
                  sufixIcon: Icon(
                    Icons.visibility_off_outlined,
                    color: ThemeColors.lightBgColor,
                  ),
                  hintText: "Password",
                  radius: 30,
                  fillColor: ThemeColors.fillColor,
                  keyboardType: TextInputType.text,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value),
                ),
              ),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Reset Password?',
                        style: TextStyle(
                          color: ThemeColors.green,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: CustomButton8(
                  text: "Sign In",
                  backgroundColor: ThemeColors.green,
                  radius: 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavBarView(),
                      ),
                    );
                  },
                  textColor: ThemeColors.mainColor,
                ),
              ),
              SizedBox(height: MySize.size30),
              Text(
                'Or',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.grey4,
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MySize.size30),
              Platform.isAndroid
                  ? Padding(
                      padding: Spacing.horizontal(MySize.size25),
                      child: CustomSocialButton(
                        text: "Sign In With Google",
                        onPressed: () {},
                        image: icGoogle,
                        backgroundColor: ThemeColors.fillColor,
                        borderColor: ThemeColors.borderColor,
                        radius: 30,
                        textColor: ThemeColors.bgColor,
                      ),
                    )
                  : Padding(
                      padding: Spacing.horizontal(MySize.size25),
                      child: CustomSocialButton(
                        text: "Sign In With Apple",
                        onPressed: () {},
                        image: icApple,
                        backgroundColor: ThemeColors.fillColor,
                        borderColor: ThemeColors.borderColor,
                        radius: 30,
                        textColor: ThemeColors.bgColor,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:falconsesportsapp/helper/common_functions.dart';
import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:falconsesportsapp/widgets/custom_textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.bgColor,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Sign In',
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
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: CustomTextField13(
                  controller: fullnameController,
                  prefixIcon: Padding(
                    padding: Spacing.all(MySize.size12),
                    child: SvgPicture.asset(
                      icEnvelope,
                      color: const Color(0xFFFFFFff).withOpacity(.2),
                    ),
                  ),
                  hintText: "Full Name",
                  radius: 30,
                  fillColor: ThemeColors.fillColor,
                  keyboardType: TextInputType.name,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value),
                ),
              ),
              SizedBox(height: MySize.size15),
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
                  hintText: "Create Password",
                  radius: 30,
                  fillColor: ThemeColors.fillColor,
                  keyboardType: TextInputType.text,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size30),
                child: Text(
                  'Use Uper Case, Lower Case Laters, Numbers & Special Character #,@, e.g',
                  style: TextStyle(
                    color: ThemeColors.grey4,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w400,
                  ),
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
                  hintText: "Confirm Password",
                  radius: 30,
                  fillColor: ThemeColors.fillColor,
                  keyboardType: TextInputType.text,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value),
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size25),
                child: CustomButton8(
                  text: "Sign In",
                  backgroundColor: ThemeColors.green,
                  radius: 30,
                  onPressed: () {},
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
                        text: "Sign Up With Google",
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
                        text: "Sign Up With Apple",
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

import 'package:chatbot/views/signup/provider/signup_provider.dart';
import 'package:flutter/material.dart';
import 'package:chatbot/helper/common_functions.dart';
import 'package:chatbot/helper/mySize.dart';
import 'package:chatbot/helper/theme_helper.dart';
import 'package:chatbot/widgets/custom_buttons.dart';
import 'package:chatbot/widgets/custom_textfields.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MySize.size60),
              Padding(
                padding: Spacing.horizontal(MySize.size23),
                child: Text(
                  'Sign Up to Chat',
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: MySize.size8),
              Padding(
                padding: Spacing.horizontal(MySize.size23),
                child: Text(
                  'Please fill your detail to access your account.',
                  style: TextStyle(
                    color: ThemeColors.grey2,
                    fontSize: MySize.size14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size56),
              Consumer<SignUpProvider>(
                builder: (context, p, child) => Form(
                  key: _signUpKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: Spacing.horizontal(MySize.size23),
                        child: CustomTextField13(
                          controller: p.fullNameController,
                          fillColor: Colors.transparent,
                          radius: 8,
                          title: "Full Name",
                          hintText: "John Doe",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            return CommonFunctions.validateTextField(
                                value, context);
                          },
                        ),
                      ),
                      SizedBox(height: MySize.size14),
                      Padding(
                        padding: Spacing.horizontal(MySize.size23),
                        child: CustomTextField13(
                          controller: p.emailController,
                          fillColor: Colors.transparent,
                          radius: 8,
                          title: "Email",
                          hintText: "john.doe@example.com",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            return CommonFunctions.validateTextField(
                                value, context);
                          },
                        ),
                      ),
                      SizedBox(height: MySize.size14),
                      Padding(
                        padding: Spacing.horizontal(MySize.size23),
                        child: CustomTextField13(
                          controller: p.passwordController,
                          fillColor: Colors.transparent,
                          radius: 8,
                          title: "Password",
                          hintText: "Password",
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          obscureText: p.obsecurePassword,
                          sufixIcon: p.obsecurePassword
                              ? GestureDetector(
                                  onTap: () {
                                    p.changeObsecureValue();
                                  },
                                  child: const Icon(
                                    Icons.visibility_off_outlined,
                                    color: ThemeColors.grey2,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    p.changeObsecureValue();
                                  },
                                  child: const Icon(
                                    Icons.visibility_outlined,
                                    color: ThemeColors.grey2,
                                  ),
                                ),
                          validator: (value) {
                            return CommonFunctions.validateTextField(
                                value, context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: MySize.size46),
              Consumer<SignUpProvider>(
                builder: (context, p, child) => Padding(
                  padding: Spacing.horizontal(MySize.size23),
                  child: p.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: ThemeColors.mainColor,
                          ),
                        )
                      : CustomButton8(
                          text: "Sign Up",
                          backgroundColor: ThemeColors.mainColor,
                          textColor: ThemeColors.bgColor,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (_signUpKey.currentState!.validate()) {
                              p.signUpWithFirebase();
                            }
                          },
                        ),
                ),
              ),
              SizedBox(height: MySize.size84),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

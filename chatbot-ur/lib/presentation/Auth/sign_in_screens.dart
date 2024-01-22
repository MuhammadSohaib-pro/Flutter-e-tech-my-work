import 'package:flutter/material.dart';
import 'package:chatbot/core/app_export.dart';
import 'package:chatbot/widgets/custom_elevated_button.dart';
import 'package:chatbot/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignInScreens extends StatelessWidget {
  SignInScreens({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    height: 780.v,
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 22.h, vertical: 83.v),
                    child: Stack(alignment: Alignment.bottomCenter, children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              height: 328.adaptSize,
                              width: 328.adaptSize,
                              margin: EdgeInsets.only(top: 126.v),
                              decoration: BoxDecoration(
                                  color: appTheme.deepPurpleA1000f,
                                  borderRadius: BorderRadius.circular(164.h)))),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                              padding: EdgeInsets.only(left: 2.h),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("lbl_login_to_chat".tr,
                                        style: theme.textTheme.headlineLarge),
                                    SizedBox(height: 9.v),
                                    Text("msg_please_fill_your".tr,
                                        style: CustomTextStyles
                                            .bodyMediumInterBluegray500),
                                    SizedBox(height: 59.v),
                                    Text("lbl_email".tr,
                                        style: theme.textTheme.titleSmall),
                                    SizedBox(height: 9.v),
                                    CustomTextFormField(
                                        controller: emailController,
                                        hintText: "msg_jpnh_doe_example_com".tr,
                                        textInputType:
                                            TextInputType.emailAddress),
                                    SizedBox(height: 15.v),
                                    Text("lbl_password".tr,
                                        style: theme.textTheme.titleSmall),
                                    SizedBox(height: 9.v),
                                    CustomTextFormField(
                                        controller: passwordController,
                                        hintText: "lbl".tr,
                                        textInputAction: TextInputAction.done,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        obscureText: true),
                                    SizedBox(height: 16.v),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("msg_forgot_password".tr,
                                            style: CustomTextStyles
                                                .titleSmallPrimary_1)),
                                    SizedBox(height: 32.v),
                                    CustomElevatedButton(
                                        height: 50.v,
                                        text: "lbl_sign_in".tr,
                                        buttonStyle:
                                            CustomButtonStyles.fillPrimary,
                                        buttonTextStyle: CustomTextStyles
                                            .titleMediumInterOnPrimary,
                                        onPressed: () {
                                          onTapSignIn(context);
                                        }),
                                    SizedBox(height: 88.v),
                                    Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                            onTap: () {
                                              onTapTxtDonthaveanaccount(
                                                  context);
                                            },
                                            child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          "msg_don_t_have_an_account2"
                                                              .tr,
                                                      style: CustomTextStyles
                                                          .bodyMediumInterOnPrimaryContainer),
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                      text: "lbl_sign_up".tr,
                                                      style: CustomTextStyles
                                                          .titleSmallPrimary)
                                                ]),
                                                textAlign: TextAlign.left)))
                                  ])))
                    ])))));
  }

  /// Navigates to the chatScreen when the action is triggered.
  onTapSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chatScreen);
  }

  /// Navigates to the signInScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signUpScreen);
  }
}

import 'package:flutter/material.dart';
import 'package:chatbot/core/app_export.dart';
import 'package:chatbot/widgets/custom_elevated_button.dart';
import 'package:chatbot/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();

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
                        EdgeInsets.symmetric(horizontal: 21.h, vertical: 83.v),
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
                              padding: EdgeInsets.only(right: 3.h),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(left: 3.h),
                                        child: Text("lbl_sign_up_to_chat".tr,
                                            style:
                                                theme.textTheme.headlineLarge)),
                                    SizedBox(height: 9.v),
                                    Padding(
                                        padding: EdgeInsets.only(left: 3.h),
                                        child: Text("msg_please_fill_your".tr,
                                            style: CustomTextStyles
                                                .bodyMediumInterBluegray500)),
                                    SizedBox(height: 27.v),
                                    Text("lbl_full_name".tr,
                                        style: theme.textTheme.titleSmall),
                                    SizedBox(height: 9.v),
                                    _buildFullName(context),
                                    SizedBox(height: 15.v),
                                    Padding(
                                        padding: EdgeInsets.only(left: 3.h),
                                        child: Text("lbl_email".tr,
                                            style: theme.textTheme.titleSmall)),
                                    SizedBox(height: 9.v),
                                    _buildEmail(context),
                                    SizedBox(height: 15.v),
                                    Padding(
                                        padding: EdgeInsets.only(left: 3.h),
                                        child: Text("lbl_password".tr,
                                            style: theme.textTheme.titleSmall)),
                                    SizedBox(height: 9.v),
                                    _buildPassword(context),
                                    SizedBox(height: 66.v),
                                    _buildSignUp(context),
                                    SizedBox(height: 88.v),
                                    Align(
                                        alignment: Alignment.center,
                                        child: GestureDetector(
                                            onTap: () {
                                              onTapTxtAlreadyhavean(context);
                                            },
                                            child: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text:
                                                          "msg_already_have_an2"
                                                              .tr,
                                                      style: CustomTextStyles
                                                          .bodyMediumInterOnPrimaryContainer),
                                                  const TextSpan(text: " "),
                                                  TextSpan(
                                                      text: "lbl_sign_in".tr,
                                                      style: CustomTextStyles
                                                          .titleSmallPrimary)
                                                ]),
                                                textAlign: TextAlign.left)))
                                  ])))
                    ])))));
  }

  /// Section Widget
  Widget _buildFullName(BuildContext context) {
    return CustomTextFormField(
        controller: fullNameController, hintText: "lbl_john_doe".tr);
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 3.h),
        child: CustomTextFormField(
            controller: emailController,
            hintText: "msg_jpnh_doe_example_com".tr,
            textInputType: TextInputType.emailAddress));
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 3.h),
        child: CustomTextFormField(
            controller: passwordController,
            hintText: "lbl".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true));
  }

  /// Section Widget
  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
        height: 50.v,
        text: "lbl_sign_up2".tr,
        margin: EdgeInsets.only(left: 3.h),
        buttonStyle: CustomButtonStyles.fillPrimary,
        buttonTextStyle: CustomTextStyles.titleMediumInterOnPrimary,
        onPressed: () {
          onTapSignUp(context);
        });
  }

  /// Navigates to the chatScreen when the action is triggered.
  onTapSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chatScreen);
  }

  /// Navigates to the signInOneScreen when the action is triggered.
  onTapTxtAlreadyhavean(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signInScreen);
  }
}

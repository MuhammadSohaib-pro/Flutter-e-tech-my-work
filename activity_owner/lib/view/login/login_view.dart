import 'package:activity_owner/helper/common_functions.dart';
import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/signup/signup_view.dart';
import 'package:activity_owner/view/verify_otp/verification_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/custom_textfields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
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
              AppLocalizations.of(context)!.requestAccount.toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size12,
                fontWeight: FontWeight.w500,
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
              Image.asset(imgLogoBlue),
              SizedBox(height: MySize.size15),
              Text(
                AppLocalizations.of(context)!.signIn.toString(),
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.signInDescrp.toString(),
                style: TextStyle(
                  color: ThemeColors.grey1,
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MySize.size50),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: AppLocalizations.of(context)!.email.toString(),
                  keyboardType: TextInputType.emailAddress,
                  radius: 30,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: AppLocalizations.of(context)!.password.toString(),
                  keyboardType: TextInputType.text,
                  radius: 30,
                  sufixIcon: const Icon(
                    Icons.visibility_off_outlined,
                    color: ThemeColors.grey1,
                  ),
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size8),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        resetPasswordBottomSheet(context);
                      },
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.forgotPassword.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.signIn.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VerificationView(),
                      ),
                    );
                  },
                  radius: 30,
                  backgroundColor: ThemeColors.mainColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  resetPasswordBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: GestureDetector(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: MySize.size320,
                decoration: const BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: Spacing.fromLTRB(0, 0, 0, 0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!
                              .resetPassword
                              .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: Spacing.horizontal(MySize.size32),
                      child: CustomTextField13(
                        controller: TextEditingController(),
                        hintText:
                            AppLocalizations.of(context)!.email.toString(),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        fillColor: ThemeColors.fillColor,
                        validator: (value) {
                          return CommonFunctions.validateTextField(
                              value, context);
                        },
                      ),
                    ),
                    SizedBox(height: MySize.size10),
                    Padding(
                      padding:
                          Spacing.fromLTRB(MySize.size32, 0, MySize.size32, 0),
                      child: Text(
                        AppLocalizations.of(context)!
                            .resetPasswordDescrp
                            .toString(),
                        style: TextStyle(
                          color: ThemeColors.grey1,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: Spacing.fromLTRB(
                          MySize.size32, 0, MySize.size32, MySize.size20),
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!.reset.toString(),
                        onPressed: () {},
                        backgroundColor: ThemeColors.mainColor,
                        textColor: ThemeColors.bgColor,
                        radius: 30,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

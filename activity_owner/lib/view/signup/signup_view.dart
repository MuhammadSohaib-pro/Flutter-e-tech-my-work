import 'package:activity_owner/view/signup/request_success_view.dart';
import 'package:flutter/material.dart';
import 'package:activity_owner/helper/common_functions.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/custom_textfields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        title: Text(
          AppLocalizations.of(context)!.requestAccount.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Loginview(),
              //   ),
              // );
            },
            child: Text(
              AppLocalizations.of(context)!.signIn.toString(),
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
              SizedBox(height: MySize.size20),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: AppLocalizations.of(context)!.fullName.toString(),
                  keyboardType: TextInputType.text,
                  radius: 30,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MySize.size32),
                child: Container(
                  width: double.infinity,
                  height: MySize.size50,
                  decoration: ShapeDecoration(
                    color: ThemeColors.fillColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: Spacing.fromLTRB(MySize.size20, 0, MySize.size20, 0),
                  child: DropdownMenu<String>(
                    width: MySize.screenWidth / 1.3,
                    hintText: AppLocalizations.of(context)!.selectCategory.toString(),
                    textStyle: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w400,
                    ),
                    trailingIcon: Padding(
                      padding: Spacing.bottom(MySize.size8),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: ThemeColors.black1,
                        size: MySize.size24,
                      ),
                    ),
                    inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none,
                      contentPadding: Spacing.bottom(MySize.size6),
                      hintStyle: TextStyle(
                        color: ThemeColors.black1,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "Pedal", label: "Pedal"),
                      DropdownMenuEntry(
                          value: "Horse Riding", label: "Horse Riding"),
                      DropdownMenuEntry(
                          value: "Camel Riding", label: "Camel Riding"),
                      DropdownMenuEntry(
                          value: "Bike Riding", label: "Bike Riding")
                    ],
                    onSelected: (value) {
                      print(value);
                    },
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
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
                  hintText: AppLocalizations.of(context)!.contact.toString(),
                  keyboardType: TextInputType.text,
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
                  hintText: AppLocalizations.of(context)!.address.toString(),
                  keyboardType: TextInputType.text,
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
                  hintText: AppLocalizations.of(context)!.createPassword.toString(),
                  keyboardType: TextInputType.text,
                  radius: 30,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size38),
                child: Text(
                  AppLocalizations.of(context)!.passwordDescrp.toString(),
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  fillColor: ThemeColors.fillColor,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  hintText: AppLocalizations.of(context)!.confirmPassword.toString(),
                  keyboardType: TextInputType.text,
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
                  hintText: AppLocalizations.of(context)!.description.toString(),
                  keyboardType: TextInputType.text,
                  radius: 30,
                  maxLines: 5,
                  validator: (value) =>
                      CommonFunctions.validateTextField(value, context),
                ),
              ),
              SizedBox(height: MySize.size30),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.submit.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestSuccessView(),
                      ),
                    );
                  },
                  backgroundColor: ThemeColors.mainColor,
                  radius: 30,
                ),
              ),
              SizedBox(height: MySize.size30),
            ],
          ),
        ),
      ),
    );
  }
}

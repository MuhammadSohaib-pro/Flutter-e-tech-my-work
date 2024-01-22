import 'package:activity_owner/helper/common_functions.dart';
import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/custom_textfields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

bool view_edit_flag = false;

class _ProfileViewState extends State<ProfileView> {
  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
        fontSize: 20,
        color: ThemeColors.mainColor,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: ThemeColors.grey3,
      borderRadius: BorderRadius.circular(10),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                view_edit_flag = !view_edit_flag;
              });
            },
            child: Text(
              view_edit_flag ? "Save" : "Edit",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MySize.size30,
                width: MySize.safeWidth,
              ),
              Container(
                height: MySize.size180,
                width: MySize.size180,
                decoration: const BoxDecoration(
                  color: Color(0xffeeeffe),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Container(
                  height: MySize.size140,
                  width: MySize.size140,
                  decoration: const BoxDecoration(
                    color: Color(0xffe2e4fc),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: MySize.size48,
                    backgroundColor: Colors.lightGreen,
                  ),
                ),
              ),
              SizedBox(height: MySize.size6),
              Text(
                'John Wick',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.mainColor,
                  fontSize: MySize.size16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.edit,
                    color: ThemeColors.mainDark,
                    size: MySize.size12,
                  ),
                  Text(
                    'Edit Profile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.mainDark,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              SizedBox(height: MySize.size18),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  title: "Name",
                  hintText: "John Wick",
                  fillColor: ThemeColors.fillColor,
                  validator: (value) {
                    return CommonFunctions.validateTextField(value, context);
                  },
                ),
              ),
              SizedBox(height: MySize.size12),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  title: "Email",
                  hintText: "johnwick@gmail.com",
                  fillColor: ThemeColors.fillColor,
                  validator: (value) {
                    return CommonFunctions.validateTextField(value, context);
                  },
                ),
              ),
              SizedBox(height: MySize.size12),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  title: "Contact",
                  hintText: "+971 381538153178",
                  fillColor: ThemeColors.fillColor,
                  sufixIcon: Icon(Icons.verified,
                      color: ThemeColors.mainColor, size: MySize.size18),
                  readOnly: true,
                  onTap: () {
                    customChangePhoneNumber(context);
                  },
                  validator: (value) {
                    return CommonFunctions.validateTextField(value, context);
                  },
                ),
              ),
              SizedBox(height: MySize.size12),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomTextField13(
                  controller: TextEditingController(),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  title: "Addresss",
                  hintText: "Saudi Arabia,Riyadh",
                  fillColor: ThemeColors.fillColor,
                  validator: (value) {
                    return CommonFunctions.validateTextField(value, context);
                  },
                ),
              ),
              SizedBox(height: MySize.size12),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomTextField13(
                        controller: TextEditingController(),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        title: "Password",
                        hintText:
                            AppLocalizations.of(context)!.password.toString(),
                        fillColor: ThemeColors.fillColor,
                        sufixIcon: const Icon(
                          Icons.visibility_outlined,
                          color: ThemeColors.mainColor,
                        ),
                        validator: (value) {
                          return CommonFunctions.validateTextField(
                              value, context);
                        },
                      ),
                    ),
                    SizedBox(width: MySize.size10),
                    Container(
                      width: MySize.size60,
                      height: MySize.size25,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          // side: const BorderSide(
                          //     width: 0.50, color: ThemeColors.mainColor),
                          borderRadius: BorderRadius.circular(MySize.size5),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.reset.toString(),
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size35),
            ],
          ),
        ),
      ),
    );
  }

  customChangePhoneNumber(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MySize.size400,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size12, MySize.size11,
                      MySize.size12, MySize.size2),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,
                            size: MySize.size20, color: ThemeColors.mainColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                  padding: Spacing.horizontal(MySize.size22),
                  child: Text(
                    'Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CountryFlagNumberTextField(
                    initialvalue: "+966",
                    title: AppLocalizations.of(context)!
                        .enterPhoneNumber
                        .toString(),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.continuee.toString(),
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {
                      Navigator.pop(context);
                      customOTPVerfication(context);
                    },
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }

  customOTPVerfication(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: MySize.size400,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(MySize.size20),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size12, MySize.size11,
                      MySize.size12, MySize.size2),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.close,
                            size: MySize.size20, color: ThemeColors.mainColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  "OTP",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size8),
                Padding(
                    padding: Spacing.horizontal(MySize.size22),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum,',
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: '\n+966 21753713',
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    )),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: Column(
                    children: [
                      Pinput(
                        length: 4,
                        defaultPinTheme: defaultPinTheme,
                        validator: (s) {
                          return s == '2222' ? null : 'Pin is incorrect';
                        },
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                      ),
                      SizedBox(height: MySize.size25),
                      Text(
                        "Didn’t Received OTP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size12,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: "Verify",
                    radius: MySize.size30,
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }
}

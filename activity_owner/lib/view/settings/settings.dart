import 'package:activity_owner/helper/common_functions.dart';
import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/settings/components/settings_tile.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:activity_owner/widgets/custom_textfields.dart';
import 'package:activity_owner/widgets/scrollable_column.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

bool flag = true;

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ScrollableColumn(
          children: [
            SettingTile(
              icon: icNotification,
              title: "Get Updated",
              subtitle: "Notifications",
              showBtn: true,
              btnValue: flag,
              onChange: (p0) {
                setState(() {
                  flag = p0;
                });
              },
            ),
            SizedBox(height: MySize.size15),
            const SettingTile(
              icon: icLanguage,
              title: "Language",
              subtitle: "English",
              showBtn: false,
            ),
            SizedBox(height: MySize.size15),
            const SettingTile(
              icon: icMobile,
              title: "About App",
              subtitle: "Version 1.0",
              showBtn: false,
            ),
            SizedBox(height: MySize.size15),
            GestureDetector(
              onTap: () {
                customConfirmationDialog(context);
              },
              child: const SettingTile(
                icon: icDelete,
                title: "Delete Account",
                subtitle: "Permanent Delete",
                showBtn: false,
              ),
            ),
            const Spacer(),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: CustomButton8(
                text: "Logout",
                backgroundColor: ThemeColors.mainColor,
                textColor: ThemeColors.bgColor,
                radius: MySize.size30,
                onPressed: () {},
              ),
            ),
            SizedBox(height: MySize.size40),
          ],
        ),
      ),
    );
  }

  customConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MySize.size20),
          ),
          child: Container(
            height: MySize.size340,
            width: double.infinity,
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
            child: ScrollableColumn(
              children: [
                Padding(
                  padding: Spacing.fromLTRB(MySize.size20, MySize.size15,
                      MySize.size20, MySize.size10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.close,
                          size: MySize.size20,
                          color: ThemeColors.black1,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Delete Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MySize.size10),
                Padding(
                  padding: Spacing.horizontal(MySize.size25),
                  child: Text(
                    "Forem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF9F9F9F),
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: MySize.size20),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomTextField13(
                    controller: TextEditingController(),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    title: "Enter Your Password",
                    hintText: AppLocalizations.of(context)!.password.toString(),
                    fillColor: ThemeColors.fillColor,
                    sufixIcon: const Icon(
                      Icons.visibility_outlined,
                      color: ThemeColors.mainColor,
                    ),
                    radius: MySize.size30,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value,context);
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: "Delete",
                    backgroundColor: ThemeColors.mainColor,
                    textColor: ThemeColors.bgColor,
                    radius: MySize.size30,
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

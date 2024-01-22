import 'package:event_owner_app/helper/common_functions.dart';
import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/provider/language_provider.dart';
import 'package:event_owner_app/screens/login/login_view.dart';
import 'package:event_owner_app/screens/settings/components/setting_tile.dart';
import 'package:event_owner_app/widgets/custom_buttons.dart';
import 'package:event_owner_app/widgets/custom_textfields.dart';
import 'package:event_owner_app/widgets/scrollable_column.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
    return SafeArea(
      child: Stack(
        children: [
          ScrollableColumn(
            children: [
              SizedBox(height: MySize.size70),
              SettingTile(
                icon: icNotification,
                title: AppLocalizations.of(context)!.getUpdated.toString(),
                subtitle:
                    AppLocalizations.of(context)!.notifications.toString(),
                showBtn: true,
                btnValue: flag,
                onChange: (p0) {
                  setState(() {
                    flag = p0;
                  });
                },
              ),
              SizedBox(height: MySize.size15),
              InkWell(
                onTap: () {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Container(
                          height: MySize.size180,
                          width: MySize.size180,
                          decoration: BoxDecoration(
                              color: ThemeColors.bgColor,
                              borderRadius:
                                  BorderRadius.circular(MySize.size30)),
                          child: Consumer<AppLanguage>(
                            builder: (context, provider, child) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Select Language",
                                  style: TextStyle(
                                    color: ThemeColors.black1,
                                    fontSize: MySize.size14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: MySize.size10),
                                RadioListTile(
                                  value: "English",
                                  groupValue: provider.groupValue,
                                  title: Text(
                                    "English",
                                    style: TextStyle(
                                      color: ThemeColors.mainColor,
                                      fontSize: MySize.size12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  activeColor: ThemeColors.mainColor,
                                  onChanged: (value) {
                                    provider.changeGroupValue(value!);
                                    provider.changeLanguage(const Locale('en'));
                                    Navigator.pop(context);
                                  },
                                ),
                                RadioListTile(
                                  value: "Arabic",
                                  groupValue: provider.groupValue,
                                  title: Text(
                                    "عربی",
                                    style: TextStyle(
                                      color: ThemeColors.mainColor,
                                      fontSize: MySize.size12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  activeColor: ThemeColors.mainColor,
                                  onChanged: (value) {
                                    provider.changeGroupValue(value!);
                                    provider.changeLanguage(const Locale('ar'));
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Consumer<AppLanguage>(
                  builder: (context, provider, child) => SettingTile(
                    icon: icGlobe,
                    title: AppLocalizations.of(context)!.language.toString(),
                    subtitle: provider.appLocal == const Locale('ar')
                        ? "عربی"
                        : "English",
                    showBtn: false,
                  ),
                ),
              ),
              SizedBox(height: MySize.size15),
              InkWell(
                onTap: () {
                  customConfirmationDialog(context);
                },
                child: SettingTile(
                  icon: icDeleteAcc,
                  title: AppLocalizations.of(context)!.deleteAccount.toString(),
                  subtitle:
                      AppLocalizations.of(context)!.permanentDelete.toString(),
                  showBtn: false,
                ),
              ),
              const Spacer(),
              Padding(
                padding: Spacing.horizontal(MySize.size32),
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.logout.toString(),
                  backgroundColor: ThemeColors.mainColor,
                  textColor: ThemeColors.bgColor,
                  radius: MySize.size30,
                  onPressed: () async {
                    CommonFunctions.closeKeyboard(context);
                    await FirebaseAuth.instance.signOut().then(
                          (value) => {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                              (route) => route.isFirst,
                            ),
                          },
                        );
                  },
                ),
              ),
              SizedBox(height: MySize.size40),
            ],
          ),
          Container(
            height: MySize.size60,
            color: ThemeColors.bgColor,
            child: Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child:
                          SvgPicture.asset(icMenu, color: ThemeColors.black1),
                    );
                  }),
                  Text(
                    AppLocalizations.of(context)!.settings.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Orders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.bgColor,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                  // SvgPicture.asset(icBell, color: ThemeColors.bgColor),
                ],
              ),
            ),
          ),
        ],
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
                      InkWell(
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
                  AppLocalizations.of(context)!.deleteAccount.toString(),
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
                    AppLocalizations.of(context)!
                        .deleteAccountdescrp
                        .toString(),
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
                    title: AppLocalizations.of(context)!
                        .enterYourPassword
                        .toString(),
                    hintText: AppLocalizations.of(context)!.password.toString(),
                    fillColor: ThemeColors.fillColor,
                    sufixIcon: const Icon(
                      Icons.visibility_outlined,
                      color: ThemeColors.mainColor,
                    ),
                    radius: MySize.size30,
                    validator: (value) {
                      return CommonFunctions.validateTextField(value);
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: Spacing.horizontal(MySize.size32),
                  child: CustomButton8(
                    text: AppLocalizations.of(context)!.delete.toString(),
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

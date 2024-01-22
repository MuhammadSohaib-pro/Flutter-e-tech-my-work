import 'package:event_manager_app/helper/exports.dart';
import 'package:event_manager_app/screens/aboutus/aboutus_view.dart';
import 'package:event_manager_app/screens/login/login_view.dart';
import 'package:event_manager_app/screens/privacy_policy/privacy_policy_view.dart';
import 'package:event_manager_app/screens/profile/profile_view.dart';
import 'package:event_manager_app/screens/settings/components/setting_tile.dart';

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
        backgroundColor: ThemeColors.bgColor,
        title: Text(
          AppLocalizations.of(context)!.settings.toString(),
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
            SizedBox(height: MySize.size20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileView(),
                  ),
                );
              },
              child: SettingTile(
                icon: icPerson,
                title: AppLocalizations.of(context)!.profile.toString(),
                subtitle: AppLocalizations.of(context)!.personalInfo.toString(),
                showBtn: false,
              ),
            ),
            SizedBox(height: MySize.size15),
            SettingTile(
              icon: icNotification,
              title: AppLocalizations.of(context)!.getUpdated.toString(),
              subtitle: AppLocalizations.of(context)!.notifications.toString(),
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
                            borderRadius: BorderRadius.circular(MySize.size30)),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyAndTermsView(),
                  ),
                );
              },
              child: SettingTile(
                icon: icKeyHole,
                title: AppLocalizations.of(context)!.privacy.toString(),
                subtitle: AppLocalizations.of(context)!.privacyTerms.toString(),
                showBtn: false,
              ),
            ),
            SizedBox(height: MySize.size15),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsView(),
                  ),
                );
              },
              child: SettingTile(
                icon: icInfo,
                title: AppLocalizations.of(context)!.aboutUs.toString(),
                subtitle: AppLocalizations.of(context)!.aboutUs.toString(),
                showBtn: false,
              ),
            ),
            SizedBox(height: MySize.size15),
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
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                    (route) => route.isFirst,
                  );

                  // await FirebaseAuth.instance.signOut().then(
                  //       (value) => {
                  //         Navigator.pushAndRemoveUntil(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => const LoginView()),
                  //           (route) => route.isFirst,
                  //         ),
                  //       },
                  //     );
                },
              ),
            ),
            SizedBox(height: MySize.size40),
          ],
        ),
      ),
    );
  }
}

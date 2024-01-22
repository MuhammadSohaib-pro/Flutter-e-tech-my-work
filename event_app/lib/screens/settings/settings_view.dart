import 'package:event_app/helper/imports.dart';
import 'package:event_app/screens/about_us/about_us_view.dart';
import 'package:event_app/screens/privacy_policy/privacy_policy_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.black1,
            fontSize: MySize.size16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ScrollableColumn(
          children: [
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutUsView(),
                    ),
                  );
                },
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                child: SettingTile(
                  icon: icInfo,
                  title: AppLocalizations.of(context)!.aboutus.toString(),
                  subtitle: AppLocalizations.of(context)!.aboutus.toString(),
                  showBtn: false,
                ),
              ),
            ),
            SizedBox(height: MySize.size15),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyAndTermsView(),
                    ),
                  );
                },
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                child: SettingTile(
                  icon: icKeyHole,
                  title: AppLocalizations.of(context)!.privacy.toString(),
                  subtitle:
                      AppLocalizations.of(context)!.privacyTerms.toString(),
                  showBtn: false,
                ),
              ),
            ),
            SizedBox(height: MySize.size15),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: InkWell(
                onTap: () async {
                  await customConfirmationDialog(context);
                },
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                child: SettingTile(
                  icon: icDeleteAcc,
                  title: AppLocalizations.of(context)!.deleteAccount.toString(),
                  subtitle:
                      AppLocalizations.of(context)!.permanentDelete.toString(),
                  showBtn: false,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: CustomButton8(
                text: AppLocalizations.of(context)!.logout.toString(),
                backgroundColor: ThemeColors.mainColor,
                radius: 30,
                onPressed: () async {
                  CommonFunctions.closeKeyboard(context);
                  await FirebaseAuth.instance.signOut().then(
                        (value) => {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                            (route) => false,
                          ),
                        },
                      );
                },
              ),
            ),
            SizedBox(height: MySize.size30),
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
            height: MySize.size380,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: MySize.size20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.deleteAccount.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
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
                    controller: passwordController,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    title: AppLocalizations.of(context)!
                        .enterYourPassword
                        .toString(),
                    hintText: AppLocalizations.of(context)!.password.toString(),
                    fillColor: const Color(0xFFF6F6F6),
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
                const Spacer(),
                // SizedBox(height: MySize.size20),
              ],
            ),
          ),
        );
      },
    );
  }
}

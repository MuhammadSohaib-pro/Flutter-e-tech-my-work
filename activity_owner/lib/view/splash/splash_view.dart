import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/onboarding/onboarding_one_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const OnboardingOneView(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF020A29), // Color(0xFF0E1632),
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              imgBgSplash,
              fit: BoxFit.fill,
              width: MySize.safeWidth,
            ),
            Column(
              children: [
                SizedBox(
                  height: MySize.size180,
                  width: MySize.safeWidth,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MySize.size225,
                    height: MySize.size225,
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.019999999552965164),
                      shape: const CircleBorder(),
                    ),
                    padding: Spacing.horizontal(MySize.size25),
                    alignment: Alignment.center,
                    child: Image.asset(imgLogoWhite),
                  ),
                ),
                SizedBox(height: MySize.size6),
                Text(
                  AppLocalizations.of(context)!.activityOwner.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

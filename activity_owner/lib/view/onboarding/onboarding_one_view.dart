import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/onboarding/onboarding_two_view.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OnboardingOneView extends StatefulWidget {
  const OnboardingOneView({super.key});

  @override
  State<OnboardingOneView> createState() => _OnboardingOneViewState();
}

class _OnboardingOneViewState extends State<OnboardingOneView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeColors.bgColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: Image.asset(imgOnboarding1),
            ),
            const Spacer(),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                AppLocalizations.of(context)!.controlYourActivities.toString(),
                style: TextStyle(
                  color: ThemeColors.black1,
                  fontSize: MySize.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: MySize.size8, width: MySize.safeWidth),
            Padding(
              padding: Spacing.horizontal(MySize.size32),
              child: Text(
                AppLocalizations.of(context)!.controlYourActivitiesDescrp.toString(),
                style: TextStyle(
                  color: ThemeColors.grey1,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MySize.size190,
                child: CustomButton8(
                  text: AppLocalizations.of(context)!.next.toString(),
                  onPressed: () {
                    Navigator.push(context, _createRoute());
                  },
                  backgroundColor: ThemeColors.mainColor,
                  radius: MySize.size30,
                ),
              ),
            ),
            SizedBox(height: MySize.size50),
          ],
        ),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const OnboardingTwoView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

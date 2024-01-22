import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/login/login_view.dart';
import 'package:activity_owner/view/signup/signup_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:activity_owner/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(imgLogoBlue),
                  SizedBox(height: MySize.size20),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MySize.safeHeight / 1.5,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.asset(
                  imgBgGetStarted,
                  width: MySize.safeWidth,
                  fit: BoxFit.fill,
                ),
                Column(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loginview(),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!
                            .continueToSignIn
                            .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: MySize.size20),
                    SizedBox(
                      width: MySize.size190,
                      child: CustomButton8(
                        text: AppLocalizations.of(context)!
                            .requestAccount
                            .toString(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpView(),
                            ),
                          );
                        },
                        backgroundColor: ThemeColors.bgColor,
                        radius: MySize.size30,
                        textColor: ThemeColors.mainColor,
                      ),
                    ),
                    SizedBox(height: MySize.size80),
                  ],
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}

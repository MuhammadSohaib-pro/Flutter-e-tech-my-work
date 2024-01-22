// ignore_for_file: use_build_context_synchronously

import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/screens/login/login_view.dart';
import 'package:event_owner_app/screens/splash/splash_provider.dart';
import 'package:event_owner_app/widgets/custom_buttons.dart';
import 'package:event_owner_app/widgets/scrollable_column.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardingView3 extends StatelessWidget {
  const OnBoardingView3({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ScrollableColumn(
                children: [
                  Container(
                    height: MySize.screenHeight / 3,
                    width: MySize.safeWidth,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(1000),
                        bottomLeft: Radius.circular(1000),
                      ),
                      color: ThemeColors.mainColor,
                    ),
                  ),
                  SizedBox(height: MySize.size180),
                  Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .getMoreCustomers
                            .toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.mainColor,
                          fontSize: MySize.size24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: MySize.size5),
                      Padding(
                        padding: Spacing.symmetric(horizontal: MySize.size32),
                        child: Text(
                          AppLocalizations.of(context)!
                              .getMoreCustomersDescrip
                              .toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.black1,
                            fontSize: MySize.size12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MySize.size5,
                        height: MySize.size5,
                        decoration: ShapeDecoration(
                          color: ThemeColors.grey2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(MySize.size30),
                          ),
                        ),
                      ),
                      SizedBox(width: MySize.size4),
                      Container(
                        width: MySize.size5,
                        height: MySize.size5,
                        decoration: ShapeDecoration(
                          color: ThemeColors.grey2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(MySize.size30),
                          ),
                        ),
                      ),
                      SizedBox(width: MySize.size4),
                      Container(
                        width: MySize.size34,
                        height: MySize.size5,
                        decoration: ShapeDecoration(
                          color: ThemeColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(MySize.size30),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.size40),
                  Padding(
                    padding: Spacing.symmetric(horizontal: MySize.size32),
                    child: CustomButton8(
                      text: AppLocalizations.of(context)!.getStarted.toString(),
                      onPressed: () async {
                        final obj =
                            Provider.of<SplashProvider>(context, listen: false);
                        await obj.onboardingSettings();

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                          (route) => false,
                        );
                      },
                      radius: MySize.size30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                    ),
                  ),
                  SizedBox(height: MySize.size50),
                ],
              ),
            ],
          ),
          Positioned(
            top: 80,
            child: SizedBox(
              child: Image.asset(imgOnboarding3),
            ),
          )
        ],
      ),
    );
  }
}

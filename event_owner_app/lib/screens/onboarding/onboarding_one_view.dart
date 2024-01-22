import 'package:event_owner_app/helper/constant.dart';
import 'package:event_owner_app/helper/mySize.dart';
import 'package:event_owner_app/helper/theme_helper.dart';
import 'package:event_owner_app/screens/onboarding/onboarding_two_view.dart';
import 'package:event_owner_app/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingView1 extends StatelessWidget {
  const OnBoardingView1({super.key});

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
              Column(
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
                        AppLocalizations.of(context)!.deliverFoodAnyWhere.toString(),
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
                          AppLocalizations.of(context)!.deliverFoodAnyWhereDescrip.toString(),
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
                        width: MySize.size34,
                        height: MySize.size5,
                        decoration: ShapeDecoration(
                          color: ThemeColors.mainColor,
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
                        width: MySize.size5,
                        height: MySize.size5,
                        decoration: ShapeDecoration(
                          color: ThemeColors.grey2,
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
                      text: AppLocalizations.of(context)!.next.toString(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnBoardingView2(),
                          ),
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
            top: 50,
            child: SizedBox(
              child: Image.asset(imgOnboarding1),
            ),
          )
        ],
      ),
    );
  }
}

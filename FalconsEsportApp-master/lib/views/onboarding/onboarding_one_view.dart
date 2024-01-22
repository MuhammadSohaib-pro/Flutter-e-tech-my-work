import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/login/login_register_view.dart';
import 'package:falconsesportsapp/views/onboarding/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OnBoardingView1 extends StatefulWidget {
  const OnBoardingView1({super.key});

  @override
  State<OnBoardingView1> createState() => _OnBoardingView1State();
}

class _OnBoardingView1State extends State<OnBoardingView1> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<OnboardingProvider>(
          builder: (context, p, child) => Column(
            children: [
              Container(
                height: MySize.size250,
                width: MySize.safeWidth,
                decoration: BoxDecoration(
                  gradient: p.index == 0
                      ? const LinearGradient(
                          begin: Alignment(-0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFFFEC3A), Color(0xFF1B1C1E)],
                        )
                      : p.index == 1
                          ? const LinearGradient(
                              begin: Alignment(-0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFEADEFF), Color(0xFF1B1C1E)],
                            )
                          : const LinearGradient(
                              begin: Alignment(-0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [Color(0xFFDF0815), Color(0xFF1B1C1E)],
                            ),
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SvgPicture.asset(icOnboardingRectangle,
                        height: MySize.safeHeight),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          p.index == 0
                              ? 'CALL OF DUTY'
                              : p.index == 1
                                  ? "PUBG"
                                  : "FREE FIRE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xFFA2972F),
                            fontSize: MySize.size16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: MySize.size15),
                        Container(
                          width: MySize.size155,
                          height: MySize.size155,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: p.index == 0
                                  ? const AssetImage(imgCod)
                                  : p.index == 1
                                      ? const AssetImage(imgPubg)
                                      : const AssetImage(imgFreeFire),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: MySize.size60),
              Text(
                'Start Watching Your\nFavourites Games',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.bgColor,
                  fontSize: MySize.size28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MySize.size17),
              Text(
                'Unlock the extraordinary live stream adventure',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.grey4,
                  fontSize: MySize.size16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: MySize.size30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  p.index == 0
                      ? Container(
                          width: MySize.size34,
                          height: MySize.size4,
                          decoration: ShapeDecoration(
                            color: ThemeColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )
                      : Container(
                          width: MySize.size17,
                          height: MySize.size4,
                          decoration: ShapeDecoration(
                            color: ThemeColors.bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                  SizedBox(width: MySize.size4),
                  p.index == 1
                      ? Container(
                          width: MySize.size34,
                          height: MySize.size4,
                          decoration: ShapeDecoration(
                            color: ThemeColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )
                      : Container(
                          width: MySize.size17,
                          height: MySize.size4,
                          decoration: ShapeDecoration(
                            color: ThemeColors.bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                  SizedBox(width: MySize.size4),
                  p.index == 2
                      ? Container(
                          width: MySize.size34,
                          height: MySize.size4,
                          decoration: ShapeDecoration(
                            color: ThemeColors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        )
                      : Container(
                          width: MySize.size17,
                          height: MySize.size4,
                          decoration: ShapeDecoration(
                            color: ThemeColors.bgColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (p.index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginRegisterView(),
                      ),
                    );
                    // p.index = 0;
                  }else{
                    p.index++;
                  }
                },
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                child: Container(
                  width: MySize.size95,
                  height: MySize.size120,
                  decoration: const ShapeDecoration(
                    color: Color(0x0F18B35B),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: Color(0x2D18B35B),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: Spacing.only(
                      top: MySize.size18,
                      left: MySize.size18,
                      right: MySize.size18,
                      bottom: MySize.size42,
                    ),
                    child: Container(
                      width: MySize.size50,
                      height: MySize.size50,
                      decoration: const ShapeDecoration(
                        color: ThemeColors.green,
                        shape: CircleBorder(),
                        shadows: [
                          BoxShadow(
                            color: Color(0x4218B35B),
                            blurRadius: 20,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: ThemeColors.bgColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

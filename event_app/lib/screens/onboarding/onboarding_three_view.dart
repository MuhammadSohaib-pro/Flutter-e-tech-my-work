// ignore_for_file: use_build_context_synchronously

import 'package:event_app/helper/imports.dart';
import 'package:event_app/screens/splash/splash_provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView3 extends StatefulWidget {
  const OnBoardingView3({super.key});

  @override
  State<OnBoardingView3> createState() => _OnBoardingView3State();
}

class _OnBoardingView3State extends State<OnBoardingView3>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.3,
      upperBound: 0.4,
    );
    _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    Future.delayed(const Duration(microseconds: 100), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

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
                        AppLocalizations.of(context)!.plates.toString(),
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
                          AppLocalizations.of(context)!.loremIpsum.toString(),
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
                          MaterialPageRoute(
                              builder: (context) => LoginView()),
                          (route) => false,
                        );
                      },
                      radius: 30,
                      backgroundColor: ThemeColors.mainColor,
                      textColor: ThemeColors.bgColor,
                    ),
                  ),
                  SizedBox(height: MySize.size50),
                ],
              ),
              Positioned(
                top: 100,
                child: RotationTransition(
                  turns: _curvedAnimation,
                  child: SizedBox(
                    width: MySize.size310,
                    height: MySize.size320,
                    child: SvgPicture.asset(icPage1),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 100,
            child: SizedBox(
              width: MySize.size310,
              height: MySize.size320,
              child: Image.asset(imgOnboarding3),
            ),
          )
        ],
      ),
    );
  }
}

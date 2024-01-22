// ignore_for_file: deprecated_member_use

import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/onboarding/onboarding_one_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -3.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Start the animation when the screen is first displayed
    _controller.forward();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingView1(),
          ),
        );
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MySize.safeWidth,
          height: MySize.safeHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.00, -1.00),
              end: Alignment(0, 1),
              colors: [Color(0xFF1D242D), Color(0xFF1B1C1E)],
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SvgPicture.asset(icLogoBgRectangle),
              ),
              SvgPicture.asset(
                icLogoBg,
                color: ThemeColors.bgColor.withOpacity(.1),
              ),
              // SvgPicture.asset(icLogoFront),
              SlideTransition(
                position: _offsetAnimation,
                child: SvgPicture.asset(icLogoFront),
                // Container(
                //   width: 200,
                //   height: 200,
                //   color: Colors.blue,
                //   // Your container content goes here
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/screens/onboard_page/hosreridingscreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Add a delay of 3 seconds before navigating to the next screen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the next screen (replace 'HosreRidingScreen' with your screen)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HorseRidingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF020A29),// Color(0xFF0E1632),
      body: SafeArea(
        child: Stack(

  children: [

    Opacity(
      opacity: 0.8,
      child: Image.asset(
        'assets/images/bgsplash.png',
        height: 85 * SizeConfig.heightMultiplier,
        width: 100*SizeConfig.widthMultiplier,
        fit: BoxFit.fill, // Adjust the BoxFit based on your requirement
      ),
    ),


    Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/circolor.png',width: SizeConfig.widthMultiplier*32,),

              Image.asset('assets/images/logosp.png',width: SizeConfig.widthMultiplier*45,),

            ],
          ),

          SizedBox(height:SizeConfig.heightMultiplier*2),
          Text(
            'Activity App',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.widthMultiplier*6,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),

          Text('\n\n\n'),
        ],
      ),
    )
  ],
),
        ),

    );
  }
}

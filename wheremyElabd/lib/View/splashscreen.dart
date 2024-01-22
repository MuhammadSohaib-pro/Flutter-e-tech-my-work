import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wheremyelabd/View/homescreen.dart';
import 'package:wheremyelabd/View/onboardpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Check shared preferences for userId
  Future<String?> getUserIdFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }
  Future<void> checkUserIdAndNavigate() async {
    final userId = await getUserIdFromSharedPreferences();
    if (userId != null && userId.isNotEmpty) {
      // User ID found, navigate to the home page with userId
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(userId: userId)),
        );
      } );
    } else {
      // User ID not found or empty, navigate to the onboarding page
      // Add a delay of 3 seconds before navigating to the OnboardPage
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardPage(id: true,)),
        );
    } );
  }
  }
  @override
  void initState() {
    super.initState();
    checkUserIdAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return  Scaffold(
        body:  Center(
          //app logo
            child: Image.asset(
              'assets/XMLID 3.png',
              width: screenSize.width * 0.6,
              height: screenSize.height * 0.7,
            ),
          ),


    );
  }
}

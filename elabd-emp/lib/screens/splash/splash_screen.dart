import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/shared_preferences_model.dart';
import '../home/custom_bottom_nav_bar.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final bool _isSignupCompleted = false;
  late final bool status;

  @override
  void initState() {
    // if (!_isSignupCompleted) {
    //   signup();
    // }
    Timer(const Duration(seconds: 3), () {
      // navigateUser();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FirebaseAuth.instance.currentUser != null
                  ? CustomizedBottomNavigationBar()
                  : const LoginScreen()));
    });

    super.initState();
  }

  // void signup() async {
  //   // String email = "kwaqassahil0777@gmail.com";
  //   // String password = "admin1234";
  //   final authProvider =
  //       Provider.of<AuthServiceProvider>(context, listen: false);
  //   UserCredential userCredential =
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  //   log("$userCredential", name: "userCredential");
  //   // bool signInSuccessful = await authProvider.signIn(email, password);
  //   // log("$signInSuccessful", name: "signInSuccessful");
  //
  //   setState(() {
  //     _isSignupCompleted = true;
  //   });
  // }

  void navigateUser() async {
    status = getIt<SharedPreferencesModel>().getLoginStatus();

    if (status == true) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return CustomizedBottomNavigationBar();
      }));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const LoginScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: 125,
                  height: 130,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/splash_img.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Elabd App",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              // const Text(
              //   "eLabd Employee App",
              //   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:event_app/helper/imports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        bool? onbaordingFlag = prefs.getBool('onboardingWatched');
        print("onboardingWatched::: $onbaordingFlag");
        if (onbaordingFlag == null || onbaordingFlag == false) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBoardingView1(),
            ),
          );
        } else {
          bool flag = false;
          await FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              flag = true;
              print("object null");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginView(),
                ),
              );
            } else {
              flag = false;
              print("object not null");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavBarView()),
                (route) => false,
              );
            }
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  height: MySize.screenHeight / 2,
                  width: MySize.safeWidth,
                  decoration: const BoxDecoration(
                    color: ThemeColors.mainColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MySize.size220,
            width: MySize.size220,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgLogo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

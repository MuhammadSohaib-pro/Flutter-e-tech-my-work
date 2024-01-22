import 'dart:async';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../routes/routes_const.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      debugPrint(FirebaseAuth.instance.currentUser.toString());

      FirebaseAuth.instance.currentUser != null
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => BottomNavigationBarView()))
          : Navigator.pushReplacementNamed(context, login);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppIcons.imgLogo,
              height: MySize.scaleFactorHeight * 160,
              width: MySize.scaleFactorWidth * 150,
            ),
            SizedBox(
              height: MySize.size10,
            ),
            Text(
              'Elabd Admin',
              style: poppinSemiBold.copyWith(fontSize: MySize.size26),
            ),
            SizedBox(
              height: MySize.size18,
            ),
          ],
        ),
      )),
    );
  }
}

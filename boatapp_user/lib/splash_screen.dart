
import 'package:boat_app/splashservices.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   SplashServices services = SplashServices();


  // bool _rememberMe = false;
  // Future<void> _getRememberMe() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool rememberMe = prefs.getBool('rememberMe') ?? false;
  //   setState(() {
  //     _rememberMe = rememberMe;
  //   });
  //   if (rememberMe) {
  //     String? sessionToken = prefs.getString('sessionToken');
  //     if (sessionToken != null) {
  //       try {
  //         await auth.signInWithCustomToken(sessionToken);
  //         Navigator.pushNamed(
  //           context,
  //           RouteName.navBar,
  //
  //         );
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //     else{
  //       Navigator.pushNamed(context, RouteName.login);
  //     }
  //   }
  // }

  // SplashServices services = SplashServices();
  // void getRememberMe()async{
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   bool? rememberMe = sp.getBool('rememberMe');
  //   if (rememberMe != true){
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> BottomNavigationBarH(name: ' ', image: ' ',)));
  //   }
  //   else{
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginView()));
  //
  //   }
  //
  // }
  @override
  void initState() {
     services.isLogin(context);
    // Timer(Duration(seconds: 3), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
    //
    // });
//   getRememberMe();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child:SvgPicture.asset(logo),
      ),
    );
  }
}

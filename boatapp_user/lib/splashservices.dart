import 'dart:async';

import 'package:boat_app/utils/constants.dart';
import 'package:boat_app/view/auth/signIn_with_phone.dart';
import 'package:boat_app/view/auth/signin/loginscreen.dart';

import 'package:boat_app/view/bottomBar/bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SplashServices{

  void isLogin(BuildContext context)async{
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null){
      String? phoneNull = await getPhone();
      String? status = await getUserStatus(user.email!);

   if(status == 'Activate'){
     if(phoneNull == ''){
       Timer(const Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignInWithPhone()))  );

     }else{
       Timer(const Duration(seconds: 2), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomBarScreen()))  );

     }
   }else{

     Timer(const Duration(seconds: 5), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginView())));
     showDialogStatus(context, 'User is deactivated by admin, Kindly contact admin');
   }


    }
    else{
      Timer(const Duration(seconds: 3), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginView())));

    }


  }

  // void rememberMeFunction(BuildContext context)async {
  //   SharedPreferences sp = await SharedPreferences.getInstance();
  //   // String? type = sp.getString('type');
  //    // bool? rememberMe = sp.getBool('rememberMe');
  //   String? email = sp.getString('email');
  //   bool? login = sp.getBool('login');
  //    // print(type);
  //    // print(rememberMe);
  //    print(email);
  //    print('helloooooo');
  //   String? userType = await getUserType(email != null ? email: ' ');
  //
  //   if ( userType == 'emailSignUp' && login ==true) {
  //
  //       Timer( const Duration(seconds: 1), () =>
  //           Navigator.pushReplacement(context, MaterialPageRoute(
  //               builder: (context) => MyHomePage() ))
  //       );
  //
  //
  //   }
  //   else {
  //     Timer(const Duration(seconds: 1), () =>
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (context) => const Login())
  //         )
  //   );
  //   }
  // }
}
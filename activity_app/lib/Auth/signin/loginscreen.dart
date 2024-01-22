
import 'package:activityapp/Auth/authcontroller/auth_Controller.dart';
import 'package:activityapp/Auth/component/containetetfeild.dart';

import 'package:activityapp/Auth/resetpassword/resetpasswordscreen.dart';
import 'package:activityapp/Auth/signin/phone_number_verify/phonenumberscreen.dart';
import 'package:activityapp/Auth/signup/signup_screen.dart';

import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/component/resuablelogo.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/nav_bar/nav_bar_screren.dart';
import 'package:flutter/material.dart';

import '../../global/layout/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthService authService = AuthService();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // automaticallyImplyLeading: false,
        leading:GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: SizeConfig.widthMultiplier * 5.5,
            )),


        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignUpScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 5,),
              child: Center(
                child: Text(
                  'Sign Up',
                  //textAlign: TextAlign.center,
                  style: MyTextStyles.myTextStyleappbar,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(

        child: Padding(
          padding:MyEdgeInsets.appPadding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Hero(
                    tag: 'logo',
                    child: ReusableLogoStack()),
            Text(
              'Sign In',
              textAlign: TextAlign.center,
              style:MyTextStyles.boldTextStyle,),
            SizedBox(
              width: SizeConfig.widthMultiplier*70,
              child:Text(
              'Rorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero ',

              textAlign: TextAlign.center,
              style:MyTextStyles.myTextStylelightsize(SizeConfig.textMultiplier * 1.5),),
            ),
                SizedBox(height: height(context)* 0.02,),
                ContainerTextField2(
                  // validator: validateEmail(emailController.text),
                  controller: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: height(context)* 0.005,),
                ContainerTextField2(
                  controller: passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),


                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                      );
                    },
                    child: Text(
                      'Reset Password',
                   //   textAlign: TextAlign.end,
                      style: MyTextStyles.myTextStyleappbar,
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                MyButtonContainer(
                  containerColor: Color(0xFF2538E8),
                  textColor: Colors.white,
                  onTap: () {
                    // authService.signInWithEmail(context, emailController.text, passwordController.text);
            // Your onTap logic

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => NavBarScreen()),
                    // );
                  },
                  buttonText: 'Sign In',
                ),
                Text(
                  '\nor\n',

                  textAlign: TextAlign.center,
                  style:MyTextStyles.myTextStylelightsize(SizeConfig.textMultiplier * 2),),
                MyButtonContainer(
                  containerColor: Colors.black,
                  textColor: Colors.white,
                  onTap: () {
            // Your onTap logic

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                    // );
                  },
                  buttonText: 'Sign In With Apple   ',
                    icon: Icons.apple,
                ),
                MyButtonContainer(
                  containerColor: Color(0xFFf0f0f0),
                  textColor: Colors.black,
                  onTap: () {
            // Your onTap logic

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                    // );
                  },
                  buttonText: 'Sign In With Google',
                  icon: AssetImage('assets/images/googleicon.png',),
                ),
                MyButtonContainer(
                  containerColor: Colors.transparent,
                  textColor: Color(0xFF2538E8),
                  onTap: () {
            // Your onTap logic

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PhoneNumberScreen()),
                    );
                  },
                  borderColor: Color(0xFF2538E8),
                  buttonText: 'Use Phone Number',
                 // icon: AssetImage('assets/images/googleicon.png',),
                ),
            SizedBox(height: 5,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

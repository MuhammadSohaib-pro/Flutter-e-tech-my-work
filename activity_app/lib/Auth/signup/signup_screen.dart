
import 'package:activityapp/Auth/component/containetetfeild.dart';
import 'package:activityapp/Auth/signin/loginscreen.dart';
import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameCon = TextEditingController();
  final TextEditingController contactCon = TextEditingController();
  final TextEditingController createPasswordCon = TextEditingController();
  final TextEditingController confirmPasswordCon = TextEditingController();
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

        title: Text(
          'Register',
          textAlign: TextAlign.center,
          style: MyTextStyles.darkTextStyle(color: Colors.black),
        ),


        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 5,),
              child: Center(
                child: Text(
                  'Sign In',
                  //textAlign: TextAlign.center,
                  style: MyTextStyles.myTextStyleappbar,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: MyEdgeInsets.appPadding,
            child: Column(
              children: [


                    ContainerTextField2(
                      controller: fullNameCon,
                      hintText: 'Full Name',
                      keyboardType: TextInputType.name,
                      //  obscureText: true,
                    ),
                    SizedBox(height: height(context)*0.02),
                    ContainerTextField2(
                      controller: emailController,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: height(context)*0.02),
                    ContainerTextField2(
                      controller: contactCon,
                      hintText: 'Contact',
                      keyboardType: TextInputType.phone,
                      //   obscureText: true,
                    ),
                    SizedBox(height: height(context)*0.02,),
                    ContainerTextField2(
                      controller: createPasswordCon,
                      hintText: 'Create Passwoord',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                SizedBox(height: height(context)*0.01,),

                    Text(
                      'password as unique as you are your gateway to secure and seamless access.',

                      textAlign: TextAlign.left,
                      style:MyTextStyles.myTextStylelightsize(SizeConfig.textMultiplier * 1.5),),
                    SizedBox(height: SizeConfig.heightMultiplier*1.5,),
                    ContainerTextField2(
                      controller: confirmPasswordCon,
                      hintText: 'Confirm Passwoord',
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),

                SizedBox(height: SizeConfig.heightMultiplier*5,),
                    Column(
                      children:[
                    MyButtonContainer(
                      containerColor: Color(0xFF2538E8),
                      textColor: Colors.white,
                      onTap: () {
// Your onTap logic

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
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
                        SizedBox(height: height(context)*0.01,),

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
                      icon: const AssetImage('assets/images/googleicon.png',),
                    ),
                        SizedBox(height: height(context)*0.01,),

                        MyButtonContainer(
                      containerColor: Colors.transparent,
                      textColor: const Color(0xFF2538E8),
                      onTap: () {
// Your onTap logic

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                        // );
                      },
                      borderColor: const Color(0xFF2538E8),
                      buttonText: 'Use Phone Number',
                      // icon: AssetImage('assets/images/googleicon.png',),
                    ),
],),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

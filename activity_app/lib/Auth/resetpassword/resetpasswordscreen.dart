import 'package:activityapp/Auth/component/containetetfeild.dart';
import 'package:activityapp/Auth/signin/loginscreen.dart';
import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController resetPasswordCon = TextEditingController();

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
          'Reset Password',
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
        child:  Padding(
            padding: MyEdgeInsets.appPadding,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               SizedBox(height: 20,),

                Text(
                  'Hit the reset button and reclaim your account securely.'
                      ' Activity App makes password recovery a breeze for a worry-free experience',
                  textAlign: TextAlign.left,
                  style:MyTextStyles.myTextStylelightsize(SizeConfig.textMultiplier * 1.5),),
                SizedBox(height: 30,),
                ContainerTextField2(
                  controller: resetPasswordCon,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 30,),

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
                  buttonText: 'Reset',
                ),
              ],
            ),
          ),

      ),
    );
  }
}

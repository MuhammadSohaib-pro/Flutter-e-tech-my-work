import 'dart:math';

import 'package:activityapp/Auth/signin/loginscreen.dart';

import 'package:activityapp/global/component/buttoncomponent.dart';
import 'package:activityapp/global/component/resuablelogo.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/onboard_page/tripscreen.dart';
import 'package:flutter/material.dart';

class JoinUsScreen extends StatefulWidget {
  const JoinUsScreen({Key? key}) : super(key: key);

  @override
  State<JoinUsScreen> createState() => _JoinUsScreenState();
}

class _JoinUsScreenState extends State<JoinUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white70,
      resizeToAvoidBottomInset: false,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          height:  MediaQuery.of(context).size.height,


          child: Padding(
            padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height* 0.07),
            child: Column(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Hero(
                    tag: 'logo',
                    child: ReusableLogoStack()),



                Stack(

                 children: [

                   Container(
                      height: SizeConfig.heightMultiplier*68,
                      width: width(context),
//color: Colors.red,
                      child: Image.asset(
                        'assets/images/bkdgani2.gif',
                        fit: BoxFit.fill,
                      ),
                    ),
                   // Positioned(
                   //   top: SizeConfig.heightMultiplier * 24,
                   // //  left: SizeConfig.widthMultiplier * 70,
                   //   right: 5,
                   //   child: Transform.rotate(
                   //     angle: pi/7 ,/* Specify the angle in radians for rotation */
                   //     child: Row(
                   //       children: [
                   //         Image.asset(
                   //           'assets/images/boatjoin.gif',
                   //           fit: BoxFit.fill,
                   //           width: 90,
                   //           height: 75,
                   //         ),
                   //       ],
                   //     ),
                   //   ),
                   // ),
                   // Positioned(
                   //     top:SizeConfig.heightMultiplier*23.3,
                   //     left: SizeConfig.widthMultiplier*4,
                   //     child:Transform.rotate(
                   //         angle: pi/0.54 ,/* Specify the angle in radians for rotation */
                   //         child: Row(
                   //       children: [
                   //         Image.asset(
                   //           'assets/images/Journeyjoin.gif',
                   //           fit: BoxFit.fill,
                   //           width: 70,
                   //           height: 80,
                   //         ),
                   //
                   //       ],
                   //     ),),),
                   // Positioned(
                   //   top:SizeConfig.heightMultiplier*16,
                   //   left: SizeConfig.widthMultiplier*37,
                   //   child: Row(
                   //     children: [
                   //       Image.asset(
                   //         'assets/images/Horsejoin.gif',
                   //         fit: BoxFit.fill,
                   //         width: 90,
                   //         height: 100,
                   //       ),
                   //
                   //     ],
                   //   )),
                   Positioned(
                     bottom: SizeConfig.heightMultiplier*1.5,
                     left: 0,
                     right: 0,
                     child: Align(
                     alignment:  Alignment.bottomCenter,
                       child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                         children: [

                           GestureDetector(
                             onTap: (){
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => LoginScreen()),
                               );
                               print('tapped');
                             },
                             child: Text(
                               'Continue to Sign In',
                               textAlign: TextAlign.center,
                               style:MyTextStyles.MuktaTextstyle(SizeConfig.textMultiplier*2,FontWeight.w500),
                             ),
                           ),
                           SizedBox(height: SizeConfig.heightMultiplier*4.5,),
                           MyButton(
                             containerColor: Colors.white,
                             textColor: Colors.black,
                             onTap: () {
// Your onTap logic
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => TripScreen()),
                               );
                             },
                             buttonText: 'Join us',
                           ),
                           SizedBox(height: SizeConfig.heightMultiplier*1,),
                           Column(
                             //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             //crossAxisAlignment: CrossAxisAlignment.center,
                           //  mainAxisSize: MainAxisSize.min,
                             children:[
                               Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   width: SizeConfig.widthMultiplier*11,
                                   height: SizeConfig.heightMultiplier*11,
                                   decoration: ShapeDecoration(
                                     color: Colors.white,
                                     shape: CircleBorder(),
                                   ),
                                   child: Center(child: Image.asset('assets/images/googleicon.png',scale: 1.8,)),
                                 ),
                                 SizedBox(width: SizeConfig.widthMultiplier*3.5,),
                                 Container(
                                   width: SizeConfig.widthMultiplier*11,
                                   height: SizeConfig.heightMultiplier*11,
                                   decoration: ShapeDecoration(
                                     color: Colors.white,
                                     shape: CircleBorder(),
                                   ),
                                   child: Center(child: Image.asset('assets/images/appleicon.png',scale: 1.8)),
                                 ),
                                 SizedBox(width: SizeConfig.widthMultiplier*3.5,),
                                 Container(
                                   width: SizeConfig.widthMultiplier*11,
                                   height: SizeConfig.heightMultiplier*11,
                                   decoration: ShapeDecoration(
                                     color: Colors.white,
                                     shape: CircleBorder(),
                                   ),
                                   child: Center(child: Image.asset('assets/images/phoneicon.png',scale: 1.8)),
                                 ),



                               ],
                             ),
                               GestureDetector(
                                 onTap: (){
                                   print('tapped');
                                 },
                                 child: Text(
                                   'Sign in with another account?',
                                   textAlign: TextAlign.center,
                                   style:MyTextStyles.MuktaTextstyle(SizeConfig.textMultiplier*1.4,  FontWeight.w400),
                                 ),
                               ),
                     ],
                           ),


                               ],
                       ),
                     ),
                   ),

                 ],
               ),



              ], ),
          ),
        ),
      ),
    );
  }
}

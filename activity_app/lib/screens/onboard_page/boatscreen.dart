import 'package:activityapp/Auth/joinuspage.dart';
import 'package:activityapp/global/component/buttoncomponent.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/onboard_page/component/circuleimagecontaniner.dart';

import 'package:flutter/material.dart';

class BoatScreen extends StatefulWidget {
  const BoatScreen({Key? key}) : super(key: key);

  @override
  State<BoatScreen> createState() => _BoatScreenState();
}

class _BoatScreenState extends State<BoatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: SizeConfig.widthMultiplier*10,right: SizeConfig.widthMultiplier*10, top:SizeConfig.heightMultiplier*13 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              CircularImageContainer(
                containerColor: Color(0xFFF6F6F6),
                assetImagePath: 'assets/images/boattlogon.png',
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Boat',
                      style: MyTextStyles.boldTextStyle,
                    ),
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier*1),
                  Text(
                    'Sail into serenity with Activity App, where the gentle rhythm of the waves becomes the soundtrack to your aquatic escapades',
                    style: MyTextStyles.myTextStylelight,
                  ),
                ],
              ),



              MyButton(
                containerColor: Color(0xFF2538E8),
                textColor: Colors.white,
                onTap: () {
// Your onTap logic
                  Navigator.of(context).push(_createRoute());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                  // );
                },
                buttonText: 'Get Started',
              ),


            ],
          ),
        ),),);
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const JoinUsScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

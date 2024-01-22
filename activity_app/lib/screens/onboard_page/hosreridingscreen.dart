
import 'package:activityapp/global/component/buttoncomponent.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:activityapp/screens/onboard_page/component/circuleimagecontaniner.dart';
import 'package:activityapp/screens/onboard_page/tripscreen.dart';
import 'package:flutter/material.dart';

class HorseRidingScreen extends StatefulWidget {
  const HorseRidingScreen({Key? key}) : super(key: key);

  @override
  State<HorseRidingScreen> createState() => _HorseRidingScreenState();
}

class _HorseRidingScreenState extends State<HorseRidingScreen> {
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
                assetImagePath: 'assets/images/horseriding.png',
              ),



Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Horse Riding',
        style: MyTextStyles.boldTextStyle,
      ),
    ),
    SizedBox(height: SizeConfig.heightMultiplier*1),
    Text(
      'Galloping into a world of adventure, Activity App invites you to explore the beauty of horse riding, one stride at a time.',
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
              //   MaterialPageRoute(builder: (context) => TripScreen()),
              // );
            },
            buttonText: 'Next',
          ),


            ],
    ),
        ),),);
  }
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const TripScreen(),
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

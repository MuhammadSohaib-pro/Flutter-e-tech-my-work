import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class BasicS extends StatefulWidget {
  const BasicS({Key? key}) : super(key: key);

  @override
  State<BasicS> createState() => _BasicSState();
}

class _BasicSState extends State<BasicS> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/images/diamond.png',
          width: SizeConfig.widthMultiplier * 10,
          height: SizeConfig.heightMultiplier * 10,
        ),
        Text(
          'Basic Individual',
          style: MyTextStyles.latoTextstylecolor(
            SizeConfig.textMultiplier * 2,
            FontWeight.w600,
            Colors.black,
          ),
        ),
        Text(
          'Upto 2 Premium account',
          style: MyTextStyles.latoTextstylecolor(
            SizeConfig.textMultiplier * 1.4,
            FontWeight.w500,
            Colors.black.withOpacity(0.5),
          ),
        ),
        Container(
          width: SizeConfig.widthMultiplier * 75,
          height: SizeConfig.heightMultiplier * 5,
          alignment: Alignment.center,
         // clipBehavior: Clip.antiAlias,

          decoration: ShapeDecoration(
            color: Color(0xFF2538E8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            shadows: [
              BoxShadow(
                color: Color(0x2B2538E8),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Text(
            'Learn more',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.textMultiplier * 1.4,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.30,
            ),
          ),),
        
      ],
    );
  }
}

class StandardS extends StatefulWidget {
  const StandardS({Key? key}) : super(key: key);

  @override
  State<StandardS> createState() => _StandardSState();
}

class _StandardSState extends State<StandardS> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/images/diamond.png',
          width: SizeConfig.widthMultiplier * 10,
          height: SizeConfig.heightMultiplier * 10,
        ),
        Text(
          'Standard Individual',
          style: MyTextStyles.latoTextstylecolor(
            SizeConfig.textMultiplier * 2,
            FontWeight.w600,
            Colors.black,
          ),
        ),
        Text(
          'Upto 3 Premium account',
          style: MyTextStyles.latoTextstylecolor(
            SizeConfig.textMultiplier * 1.4,
            FontWeight.w500,
            Colors.black.withOpacity(0.5),
          ),
        ),
           Container(
          width: SizeConfig.widthMultiplier * 75,
          height: SizeConfig.heightMultiplier * 5,
          alignment: Alignment.center,
         // clipBehavior: Clip.antiAlias,

          decoration: ShapeDecoration(
            color: Color(0xFF2538E8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            shadows: [
              BoxShadow(
                color: Color(0x2B2538E8),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Text(
            'Learn more',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.textMultiplier * 1.4,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.30,
            ),
          ),),
     
      ],
    );
  }
}

class PremiumS extends StatefulWidget {
  const PremiumS({Key? key}) : super(key: key);

  @override
  State<PremiumS> createState() => _PremiumSState();
}

class _PremiumSState extends State<PremiumS> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/images/diamond.png',
          width: SizeConfig.widthMultiplier * 10,
          height: SizeConfig.heightMultiplier * 10,
        ),
        Text(
          'Premium Individual',
          style: MyTextStyles.latoTextstylecolor(
            SizeConfig.textMultiplier * 2,
            FontWeight.w600,
            Colors.black,
          ),
        ),
        Text(
          'Upto 5 Premium account',
          style: MyTextStyles.latoTextstylecolor(
            SizeConfig.textMultiplier * 1.4,
            FontWeight.w500,
            Colors.black.withOpacity(0.5),
          ),
        ),

           Container(
          width: SizeConfig.widthMultiplier * 75,
          height: SizeConfig.heightMultiplier * 5,
          alignment: Alignment.center,
         // clipBehavior: Clip.antiAlias,

          decoration: ShapeDecoration(
            color: Color(0xFF2538E8),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            shadows: [
              BoxShadow(
                color: Color(0x2B2538E8),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Text(
            'Learn more',
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.textMultiplier * 1.4,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.30,
            ),
          ),),
     
      ],
    );
  }
}

import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';
class LocationError extends StatefulWidget {
  const LocationError({Key? key}) : super(key: key);

  @override
  State<LocationError> createState() => _LocationErrorState();
}

class _LocationErrorState extends State<LocationError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: MyEdgeInsets.appPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //  crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  SizedBox(
                      height: SizeConfig.heightMultiplier * 20
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    children:[ Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: SizeConfig.heightMultiplier * 35,
                        child: Image.asset('assets/images/locationerror.png'),
                      ),
                    ),

                    ], ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  Text(
                    'Turn On your Location',
                    style: MyTextStyles.interTextstyle(
                        SizeConfig.textMultiplier * 2, FontWeight.w600),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1,
                  ),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 84,
                    child: Text(
                      'Sorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.',
                      textAlign: TextAlign.center,
                      style: MyTextStyles.myTextStylelightsize(
                          SizeConfig.textMultiplier * 1.5),
                    ),
                  ),

                ],
              ),
              //    Spacer(),
              // Expanded(
              //   child:
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:  MyButtonContainer(
                      containerColor: Color(0xFF2538E8),
                      textColor: Colors.white,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                        // );
                      },
                      buttonText: 'Enable',
                      width: SizeConfig.widthMultiplier*60,
                    ),

                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:  MyButtonContainer(
                      containerColor: Color(0xFFF6F6F6),//Color(0xFFEFEFEF),
                      textColor: Colors.black,
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => JoinUsScreen()),
                        // );
                      },
                      buttonText: 'Later!',
                      width: SizeConfig.widthMultiplier*60,
                    ),

                  ),
                  // ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}

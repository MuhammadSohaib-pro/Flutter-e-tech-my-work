import 'package:activityapp/global/component/buttoncontainer.dart';
import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class InterneterrorScreen extends StatefulWidget {
  const InterneterrorScreen({Key? key}) : super(key: key);

  @override
  State<InterneterrorScreen> createState() => _InterneterrorScreenState();
}

class _InterneterrorScreenState extends State<InterneterrorScreen> {
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
                        height: SizeConfig.heightMultiplier * 30,
                        child: Image.asset('assets/images/interneterror.png'),
                      ),
                    ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 5,
                      ),
                 ], ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
                  ),
                  Text(
                    'No Internet Connection!',
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
                        buttonText: 'Try Again',
                      ),

                  ),
                  // ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2,
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

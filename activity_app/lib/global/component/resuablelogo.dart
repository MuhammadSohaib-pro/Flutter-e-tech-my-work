
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:flutter/material.dart';

class ReusableLogoStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/images/logoN.png',
          width: width(context)*0.3
        ),
        // Opacity(
        //   opacity: 0.9,
        //   child: Image.asset(
        //     'assets/images/applogoblk.png',
        //     width: width(context)*0.3
        //   ),
        // ),
      ],
    );
  }
}

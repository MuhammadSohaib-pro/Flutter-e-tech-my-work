import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/sized_box.dart';

class ReusableCircle extends StatelessWidget {
  final String image;
   const ReusableCircle({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: height(context)*0.07,
      width: height(context)*0.07,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
          offset: Offset(0, 4),
            spreadRadius: 0

    )
        ],
          shape: BoxShape.circle,
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image(
          height:20,
          width: 20,
          image: AssetImage(image),),
      ),
    );
  }
}
class ReusableCircleSocial extends StatelessWidget {
  final String image;
  const ReusableCircleSocial({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Container(
      height: height(context)*0.07,
      width: height(context)*0.07,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: primaryColor.withOpacity(0.17),
                // offset: Offset(0, 0),
                spreadRadius: 0

            )
          ],
          shape: BoxShape.circle,
          color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image(
          height:20,
          width: 20,
          image: AssetImage(image),),
      ),
    );
  }
}

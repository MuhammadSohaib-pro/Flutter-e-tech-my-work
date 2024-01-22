
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color containerColor;
  final Color textColor;
  final VoidCallback onTap;
  final String buttonText;

  MyButton({
    required this.containerColor,
    required this.textColor,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.widthMultiplier * 52,
        height: SizeConfig.heightMultiplier * 7.2,
        decoration: ShapeDecoration(
          color: containerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: SizeConfig.textMultiplier * 2,
              fontFamily: 'Mukta',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}



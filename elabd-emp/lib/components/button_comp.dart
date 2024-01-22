import 'package:elabd_tms_app/constants/colors.dart';
import 'package:flutter/material.dart';

class ButtonComp extends StatelessWidget {
  final String title;
  final Color backColor;
  final double bordeRadius;
  final Function onTap;
  final Color borderColor;
  final Color textColor;

  const ButtonComp({
    super.key,
    required this.title,
    this.textColor = white,
    this.borderColor = Colors.transparent,
    this.backColor =  primaryColor,
    this.bordeRadius = 8,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: backColor,
            borderRadius: BorderRadius.circular(bordeRadius)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text(
            title,
            style: TextStyle(
                color: textColor, fontSize:12,fontWeight: FontWeight.w500),
          ),
        )),
      ),
    );
  }
}

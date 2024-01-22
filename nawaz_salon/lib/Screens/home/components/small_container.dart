import 'package:flutter/material.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class CustomHomeContainerSmall extends StatelessWidget {
  const CustomHomeContainerSmall({
    super.key,
    required this.title,
    required this.values,
  });
  final String title;
  final String values;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 154,
      decoration: const ShapeDecoration(
        color: ThemeColors.grey4,
        image: DecorationImage(
            image: AssetImage(imgContainerBg),
            fit: BoxFit.fill,
            alignment: Alignment.center),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x2B000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 27, 0, 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: ThemeColors.bgColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Text(
              values,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Josefin Sans',
                fontWeight: FontWeight.w600,
                height: 0,
                letterSpacing: -0.30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

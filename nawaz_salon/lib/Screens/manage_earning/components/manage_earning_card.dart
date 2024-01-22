import 'package:flutter/material.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class CustomManageEarningCard extends StatelessWidget {
  const CustomManageEarningCard({
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
            image: AssetImage(imgManageEarningContainer),
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
            padding: const EdgeInsets.fromLTRB(16, 19, 0, 2),
            child: Text(
              'September 2023',
              style: TextStyle(
                color: ThemeColors.yellow,
                fontSize: 10,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 2),
            child: Text(
              'Total Earning',
              style: const TextStyle(
                color: ThemeColors.bgColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: Text(
              '3,668.98',
              style: TextStyle(
                color: ThemeColors.bgColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }
}

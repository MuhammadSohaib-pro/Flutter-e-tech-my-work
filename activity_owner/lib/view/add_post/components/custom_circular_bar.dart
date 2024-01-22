import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomCircleProgressIndicator extends StatelessWidget {
  CustomCircleProgressIndicator({
    super.key,
    required this.value,
    required this.indicatorValue,
  });
  String value;
  double indicatorValue;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Stack(
      children: [
        Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: 1.0,
                  color: ThemeColors.grey6,
                  strokeWidth: MySize.size6,
                ),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            CircularProgressIndicator(
              value: indicatorValue,
              color: ThemeColors.mainColor,
              strokeWidth: MySize.size6,
            ),
          ],
        ),
      ],
    );
  }
}
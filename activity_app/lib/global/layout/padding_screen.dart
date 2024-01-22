
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:flutter/material.dart';

class MyEdgeInsets {
  static EdgeInsets appPadding = EdgeInsets.symmetric(
    horizontal: SizeConfig.widthMultiplier * 6,
   // vertical: SizeConfig.heightMultiplier * 2,
  );
  static EdgeInsets home = EdgeInsets.symmetric(
    horizontal: SizeConfig.widthMultiplier * 6,
     vertical: SizeConfig.heightMultiplier * 0,
  );
    static EdgeInsets home1 = EdgeInsets.only(
    left: SizeConfig.widthMultiplier * 5,
      right: SizeConfig.widthMultiplier * 5,
    bottom: SizeConfig.heightMultiplier * 1,
  );
  static EdgeInsets booking = EdgeInsets.only(
    top:SizeConfig.heightMultiplier * 3,
    left: SizeConfig.widthMultiplier * 5,
    right: SizeConfig.widthMultiplier * 5,
    bottom: SizeConfig.heightMultiplier * 3,
  );
  static EdgeInsets booking1 = EdgeInsets.only(
    top:SizeConfig.heightMultiplier * 0,
    left: SizeConfig.widthMultiplier * 5,
    right: SizeConfig.widthMultiplier * 5,
    bottom: SizeConfig.heightMultiplier * 2,
  );

  static EdgeInsets booking2 = EdgeInsets.only(
    top:SizeConfig.heightMultiplier * 2,
    left: SizeConfig.widthMultiplier * 5,
    right: SizeConfig.widthMultiplier * 5,
    bottom: SizeConfig.heightMultiplier * 0,
  );
}

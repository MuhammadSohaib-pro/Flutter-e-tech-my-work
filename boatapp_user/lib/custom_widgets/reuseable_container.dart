import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/sized_box.dart';

class ReusableContainer extends StatelessWidget {
  Widget? child;
   ReusableContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height(context)*0.13,
      width: width(context),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:  [BoxShadow(
            blurRadius: 10,
            color: Colors.grey.shade300,
          )],
          borderRadius: BorderRadius.circular(16)
      ),
      child: child,

    );
  }
}


class ReusableContainerWithHW extends StatelessWidget {
  Widget? child;
  Color? bgColor;
  final double? height, width;
ReusableContainerWithHW({Key? key, required this.child, this.height, this.width, this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: bgColor== null? white1 : bgColor,
          boxShadow:  [BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )],
          borderRadius: BorderRadius.circular(8)
      ),
      child: child,

    );
  }
}

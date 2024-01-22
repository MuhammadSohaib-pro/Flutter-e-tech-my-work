import 'package:flutter/material.dart';

import '../layout/mySize.dart';

class BookingContainer extends StatelessWidget {
  final double? height, width;
  final Color? color;
  final Widget? child;

  const BookingContainer({Key? key,
  this.height,
    this.width,
    this.color,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return    Container(
      height: height,
      width:width,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15)
      ),
      child:
    child
    );
  }
}

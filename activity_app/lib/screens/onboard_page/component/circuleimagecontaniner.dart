
import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:flutter/material.dart';

class CircularImageContainer extends StatelessWidget {
  final Color containerColor;
  final String assetImagePath;

  CircularImageContainer({
    required this.containerColor,
    required this.assetImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.heightMultiplier * 40,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: containerColor,
          ),
        ),
        Image.asset(assetImagePath),
      ],
    );
  }
}

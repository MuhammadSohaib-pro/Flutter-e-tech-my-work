import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:flutter/material.dart';

class CustomIconContainer extends StatelessWidget {
  final bool isSelected;
  final String imagePath;
  final String labelText;

  const CustomIconContainer({
    required this.isSelected,
    required this.imagePath,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: ShapeDecoration(
            color: isSelected ? Color(0xFF2538E8) : Color(0xFFF6F6F6),
            shape: CircleBorder(),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
              width: 14,
              height: 14,
              color: isSelected ? Colors.white : Color(0xFF2538E8),
            ),
          ),
        ),
        SizedBox(width: 6),
        Text(
          labelText,
          style: TextStyle(
            fontSize: SizeConfig.textMultiplier * 1.5,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
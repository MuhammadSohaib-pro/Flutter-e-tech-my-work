import 'package:flutter/material.dart';

class CustomButton2 extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final Color color;
  final Color textColor;
  final Icon icon;

  final VoidCallback onPressed;

  const CustomButton2(
      {super.key,
      required this.width,
      required this.textColor,
      required this.height,
      required this.text,
      required this.color,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            icon
          ],
        ),
      ),
    );
  }
}

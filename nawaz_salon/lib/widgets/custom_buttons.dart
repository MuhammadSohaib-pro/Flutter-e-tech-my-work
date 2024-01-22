import 'package:flutter/material.dart';

class CustomButton8 extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double radius;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const CustomButton8({
    super.key,
    required this.text,
    this.backgroundColor,
    required this.onPressed,
    this.textColor,
    this.radius=30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.0,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          backgroundColor: backgroundColor,
          disabledBackgroundColor: Colors.grey[300],
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? const Color(0xffFFFFFF),
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

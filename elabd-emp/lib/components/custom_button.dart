import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String? image;
  final double width;
  final double height;
  final String text;
  final Color color;
  final Color textColor;
  final double? fontSize;

  final VoidCallback onPressed;

  const CustomButton(
      {super.key,
      this.image,
      required this.width,
      required this.textColor,
      required this.height,
      required this.text,
      required this.color,
      required this.onPressed,
      this.fontSize});

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
            if (image != null) // Add a null check condition here
              Image(image: AssetImage(image!)),
            if (image != null) const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize ?? 16.sp,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

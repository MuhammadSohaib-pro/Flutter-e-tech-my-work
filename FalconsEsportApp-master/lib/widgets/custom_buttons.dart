import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Shadow custom buttons

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
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MySize.size46,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x26FFCD3B),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
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
            fontSize: MySize.size14,
          ),
        ),
      ),
    );
  }
}

class FlexibleButton extends StatelessWidget {
  const FlexibleButton({
    super.key,
    required this.height,
    required this.width,
    this.radius = 10,
    required this.textSize,
    required this.backgroundColor,
    required this.textColor,
    required this.text,
    required this.weight,
    required this.onPressed,
  });
  final double height;
  final double width;
  final double? radius;
  final double textSize;
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final FontWeight weight;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
            fontWeight: weight,
          ),
        ),
      ),
    );
  }
}

class CustomSocialButton extends StatelessWidget {
  final String text;
  final String image;
  final Color? textColor;
  final Color? borderColor;
  final double radius;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const CustomSocialButton({
    super.key,
    required this.text,
    this.backgroundColor,
    required this.onPressed,
    this.textColor,
    required this.image,
    this.radius = 10,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: onPressed,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        width: double.infinity,
        height: MySize.size46,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: borderColor ?? ThemeColors.borderColor,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            SizedBox(width: MySize.size8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Simple custom buttons

// class CustomButton8 extends StatelessWidget {
//   final String text;
//   final Color? textColor;
//   final double radius;
//   final Color? backgroundColor;
//   final VoidCallback onPressed;

//   const CustomButton8({
//     super.key,
//     required this.text,
//     this.backgroundColor,
//     required this.onPressed,
//     this.textColor,
//     this.radius = 10,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55.0,
//       child: TextButton(
//         style: TextButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(radius),
//           ),
//           backgroundColor: backgroundColor,
//           disabledBackgroundColor: Colors.grey[300],
//         ),
//         onPressed: onPressed,
//         child: Text(
//           text,
//           style: TextStyle(
//             color: textColor ?? const Color(0xffFFFFFF),
//             fontWeight: FontWeight.w500,
//             fontSize: 12,
//           ),
//         ),
//       ),
//     );
//   }
// }

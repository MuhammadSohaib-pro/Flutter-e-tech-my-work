import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class MyButtonContainer extends StatelessWidget {
  final Color containerColor;
  final Color textColor;
  final VoidCallback onTap;
  final String buttonText;
  final dynamic icon; // dynamic type to support both IconData and AssetImage
  final Color? borderColor;
  final double? width;


  MyButtonContainer({
    required this.containerColor,
    required this.textColor,
    required this.onTap,
    required this.buttonText,
    this.icon, // Support both IconData and AssetImage
    this.borderColor,
    this.width, // Optional width parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height(context) * 0.055,
        width: width, // Set width if provided, otherwise let it take full width
        decoration: BoxDecoration(
          color: containerColor,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2.0) // Add border if borderColor is provided
              : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon is IconData)
                Icon(
                  icon,
                  color: textColor,
                  size: 35,
                ),
              if (icon is AssetImage)
                ImageIcon(
                  icon,
                  // color: textColor,
                ),
              SizedBox(width: icon != null ? 8.0 : 0),
              Text(
                buttonText,
                style: MyTextStyles.darkTextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyButtonContainer2 extends StatelessWidget {
  final Color containerColor;
  final Color textColor;
  final VoidCallback onTap;
  final String buttonText;
  final dynamic icon; // dynamic type to support both IconData and AssetImage
  final Color? borderColor;
  final double? width, height;


  MyButtonContainer2({
    required this.containerColor,
    required this.textColor,
    required this.onTap,
    required this.buttonText,
    this.icon, // Support both IconData and AssetImage
    this.borderColor,
    this.width, // Optional width parameter
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width, // Set width if provided, otherwise let it take full width
        decoration: BoxDecoration(
          color: containerColor,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: 2.0) // Add border if borderColor is provided
              : null,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon is IconData)
                Icon(
                  icon,
                  color: textColor,
                  size: 35,
                ),
              if (icon is AssetImage)
                ImageIcon(
                  icon,
                  // color: textColor,
                ),
              SizedBox(width: icon != null ? 8.0 : 0),
              Text(
                buttonText,
                style: MyTextStyles.darkTextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class MyButtonContainer extends StatelessWidget {
//   final Color containerColor;
//   final Color textColor;
//   final VoidCallback onTap;
//   final String buttonText;
//   final dynamic icon; // dynamic type to support both IconData and AssetImage
//   final Color? borderColor;
//   final double? width;
//
//   MyButtonContainer({
//     required this.containerColor,
//     required this.textColor,
//     required this.onTap,
//     required this.buttonText,
//     this.icon, // Support both IconData and AssetImage
//     this.borderColor,
//     this.width, // Optional width parameter
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: SizeConfig.heightMultiplier * 7,
//         width: width, // Set width if provided, otherwise let it take full width
//         decoration: BoxDecoration(
//           color: containerColor,
//           border: borderColor != null
//               ? Border.all(color: borderColor!, width: 2.0) // Add border if borderColor is provided
//               : null,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (icon is IconData)
//                 Icon(
//                   icon,
//                   color: textColor,
//                   size: 35,
//                 ),
//               if (icon is AssetImage)
//                 ImageIcon(
//                   icon,
//                   color: textColor,
//                 ),
//               SizedBox(width: icon != null ? 8.0 : 0),
//               Text(
//                 buttonText,
//                 style: MyTextStyles.darkTextStyle(color: textColor),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

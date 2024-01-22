import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hinttext;
  final TextInputType? type;
  final int? lengthh;
  final Widget? suffixIcon;
  final Widget? prefixIcon; // New parameter for prefix icon

  const CustomTextField({
    Key? key,
    required this.hinttext,
    required this.controller,
    this.type,
    this.lengthh,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6 * width, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: type,
        maxLength: lengthh,
        style: const TextStyle(
          color: Colors.grey,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 12.sp),
          border: InputBorder.none,
          suffixIcon: suffixIcon,
          fillColor: white,
          filled: true,
        ),
      ),
    );
  }
}

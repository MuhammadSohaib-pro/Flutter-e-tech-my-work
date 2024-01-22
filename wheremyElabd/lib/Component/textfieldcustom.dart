import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;


  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351,
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle:  MyTextStyles.hinttextfield(16.0), // Use the provided font size

          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}

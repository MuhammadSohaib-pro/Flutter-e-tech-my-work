import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class CustomDescriptionField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const CustomDescriptionField({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 351,
      height: 165,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: controller,
          style: TextStyle(color: Colors.black),
          maxLines: null, // Allow multiple lines for description
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: MyTextStyles.hinttextfield(16.0),
            border: InputBorder.none, // Remove the border around the TextField
            contentPadding: EdgeInsets.all(0), // Adjust padding as needed
          ),
        ),
      ),
    );
  }
}

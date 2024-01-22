import 'package:flutter/material.dart';

class MultiLineTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final int maxLines;
  const MultiLineTextFieldWidget(
      {super.key, required this.controller, required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400),
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
          filled: true,
          contentPadding: const EdgeInsets.all(10),
          fillColor: const Color(0xffF6F6F6),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8))),
    );
  }
}

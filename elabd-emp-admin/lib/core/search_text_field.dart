import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/mySize.dart';

// ignore: must_be_immutable
class SearchTextField extends StatelessWidget {
  SearchTextField(
      {super.key,
      required this.hintText,
      this.leadingIcon,
      this.onfieldSubmission,
      this.isLeading = false,
      this.isTraling = false,
      this.tralingIcons,
      this.borderRadius = 0,
      required this.controller,
      this.onTap});
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final Function? onfieldSubmission;
  final double? borderRadius;
  bool? isLeading;

  final Widget? leadingIcon;
  bool? isTraling;
  final Widget? tralingIcons;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return TextFormField(
      onTap: onTap,
      onFieldSubmitted: (value) => onfieldSubmission,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 10),
        hintStyle: TextStyle(
            fontFamily: GoogleFonts.lato().fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: MySize.size14,
            color: const Color(0xffCACCCF)),
        filled: true,
        fillColor: const Color(0xffF6F6F6),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius!)),
        suffixIcon: isTraling! ? tralingIcons : null,
        prefixIcon: isLeading! ? leadingIcon : null,
      ),
    );

  
  }
}

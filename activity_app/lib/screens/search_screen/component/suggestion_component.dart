import 'package:activityapp/global/layout/sizeconfig.dart';
import 'package:activityapp/global/layout/textstyle.dart';
import 'package:flutter/material.dart';

class SuggestionComponent extends StatelessWidget {
  final String text;

  const SuggestionComponent({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.widthMultiplier * 26,
      height: 28,
      alignment: Alignment.center,
   //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFF0D1632),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: MyTextStyles.poppinsTextstylecolor(
          SizeConfig.textMultiplier * 1.5,
          FontWeight.w400,
          Colors.white,
        ),
      ),
    );
  }
}

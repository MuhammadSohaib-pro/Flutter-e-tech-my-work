import 'package:elabd_ems_admin/utils/app_color.dart';
import 'package:elabd_ems_admin/utils/mySize.dart';
import 'package:flutter/material.dart';

class MarkAttendanceButton extends StatelessWidget {
  const MarkAttendanceButton({super.key, required this.text, required this.btnColor, required this.onPressed});

  final String text;
  final Color btnColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 30,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: btnColor, borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TextStyle(color: whiteColor, fontSize: MySize.size14),
        ),
      ),
    );
  }
}

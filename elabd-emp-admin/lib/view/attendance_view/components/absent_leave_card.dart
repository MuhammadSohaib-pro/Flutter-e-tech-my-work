import 'package:elabd_ems_admin/utils/app_color.dart';
import 'package:elabd_ems_admin/utils/mySize.dart';
import 'package:flutter/cupertino.dart';

class AbsentLeaveCard extends StatelessWidget {
  const AbsentLeaveCard({super.key, required this.text, required this.backgroundColor});
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MySize.size50,
      alignment: Alignment.center,
      width: MySize.safeWidth / 2,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15)),
      child: Text(
        text,
        style: TextStyle(fontSize: MySize.size16, color: whiteColor),
      ),
    );
  }
}

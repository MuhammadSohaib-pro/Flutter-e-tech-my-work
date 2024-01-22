import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FacilitiesTile extends StatelessWidget {
  const FacilitiesTile({
    super.key,
    required this.checkBoxValue,
    required this.icon,
    required this.descrp,
    required this.onChanged,
  });
  final bool checkBoxValue;
  final String icon;
  final String descrp;
  final ValueChanged<bool?> onChanged;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: Row(
        children: [
          Checkbox(
            activeColor: ThemeColors.mainColor,
            value: checkBoxValue,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          SizedBox(width: MySize.size5),
          Container(
            width: MySize.size50,
            height: MySize.size50,
            decoration: const ShapeDecoration(
              color: ThemeColors.bgColor,
              shape: CircleBorder(),
              shadows: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 10,
                  offset: Offset(2, 2),
                  spreadRadius: 0,
                )
              ],
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(icon),
            //,height: MySize.size35,width: MySize.size35
          ),
          SizedBox(width: MySize.size8),
          Expanded(
            child: Text(
              descrp,
              style: TextStyle(
                color: ThemeColors.black1,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

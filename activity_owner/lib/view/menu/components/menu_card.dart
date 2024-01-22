
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          height: MySize.size56,
          decoration: ShapeDecoration(
            color: ThemeColors.bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x21000000),
                blurRadius: 20,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          padding: Spacing.horizontal(MySize.size15),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                color: ThemeColors.black1,
              ),
              SizedBox(width: MySize.size10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: ThemeColors.black1,
                      fontSize: MySize.size12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: subtitle.isEmpty ? MySize.size0 : MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

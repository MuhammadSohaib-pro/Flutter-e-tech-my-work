
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class RecentPointWidget extends StatelessWidget {
  const RecentPointWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      width: MySize.size290,
      height: MySize.size95,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: ThemeColors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 20,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: Spacing.horizontal(MySize.size16),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MySize.size64,
                  height: MySize.size64,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                  ),
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 6,
                    color: ThemeColors.bgColor.withOpacity(0.30),
                  ),
                ),
                Container(
                  width: MySize.size64,
                  height: MySize.size64,
                  decoration: const ShapeDecoration(
                    shape: OvalBorder(),
                  ),
                  child: const CircularProgressIndicator(
                    value: 0.75,
                    strokeWidth: 6,
                    color: ThemeColors.bgColor,
                  ),
                ),
                Text(
                  '2/5',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.bgColor,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(width: MySize.size22),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'VALORANT\n',
                    style: TextStyle(
                      color: ThemeColors.bgColor,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Roster Announcement',
                    style: TextStyle(
                      color: const Color(0xFF008439),
                      fontSize: MySize.size12,
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

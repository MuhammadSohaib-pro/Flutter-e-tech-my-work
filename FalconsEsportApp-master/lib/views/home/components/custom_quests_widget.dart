import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomQuestsWidget extends StatelessWidget {
  const CustomQuestsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      width: MySize.size295,
      height: MySize.size171,
      decoration: ShapeDecoration(
        color: const Color(0xFF2E2F31),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Padding(
        padding: Spacing.horizontal(MySize.size20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'VALORANT\n',
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Roster Announcement',
                        style: TextStyle(
                          color: ThemeColors.green,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                          height: 1.5
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '1 Day Left',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: ThemeColors.green,
                    fontSize: MySize.size10,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            SizedBox(height: MySize.size9),
            Text(
              'The Race to World First will take place over the course of several exhilarating days, so make sure you don’t miss a moment of it to earn as many Liquid+ points as you can!',
              style: TextStyle(
                color: ThemeColors.grey1,
                fontSize: MySize.size10,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: MySize.size9),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MySize.size95,
                  height: MySize.size20,
                  decoration: ShapeDecoration(
                    color: ThemeColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '450.00 Points',
                    style: TextStyle(
                      color: ThemeColors.bgColor,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: MySize.size40,
                  height: MySize.size40,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF858585).withOpacity(.3),
                    shape: const OvalBorder(
                      side: BorderSide(
                        width: 2.5,
                        color: ThemeColors.grey1,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '0/5',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: ThemeColors.grey1,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

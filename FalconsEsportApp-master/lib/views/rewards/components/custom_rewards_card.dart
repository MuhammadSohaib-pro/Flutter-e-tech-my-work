import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomRewardCard extends StatelessWidget {
  const CustomRewardCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Container(
      width: MySize.size285,
      height: MySize.size207,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: AssetImage(imgGaming),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: MySize.size67,
            decoration: BoxDecoration(
              color: const Color(0x4C999999).withOpacity(.80),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: Spacing.horizontal(MySize.size15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Team Liquid \n',
                          style: TextStyle(
                            color: ThemeColors.bgColor,
                            fontSize: MySize.size14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'Premium Letterman Jacket',
                          style: TextStyle(
                            color: ThemeColors.green,
                            fontSize: MySize.size10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MySize.size94,
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

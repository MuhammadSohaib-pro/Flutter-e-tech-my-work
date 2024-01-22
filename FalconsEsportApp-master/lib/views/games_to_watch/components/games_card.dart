
import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class GamesCard extends StatelessWidget {
  const GamesCard({
    super.key,
    required this.borderColor,
    required this.backgroundColor,
  });
  final Color borderColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MySize.size90,
      height: MySize.size140,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C18B35B),
            blurRadius: 50,
            offset: Offset(-10, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MySize.size2),
          Center(
            child: Container(
              height: MySize.size80,
              width: MySize.size80,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(imgPubg),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: MySize.size8),
          Padding(
            padding: Spacing.left(MySize.size8),
            child: Text(
              'Top',
              style: TextStyle(
                color: const Color(0xFF007F36),
                fontSize: MySize.size10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(height: MySize.size8),
          Padding(
            padding: Spacing.left(MySize.size8),
            child: Text(
              'PUBG',
              style: TextStyle(
                color: ThemeColors.bgColor,
                fontSize: MySize.size14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomStoryWidget extends StatelessWidget {
  const CustomStoryWidget({
    super.key,
    required this.image,
    required this.name,
  });
  final String image;
  final String name;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Container(
                  width: MySize.size60,
                  height: MySize.size60,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                    shape: const OvalBorder(
                      side: BorderSide(width: 1.50, color: ThemeColors.grey1),
                    ),
                  ),
                ),
                SizedBox(height: MySize.size4)
              ],
            ),
          ],
        ),
        SizedBox(height: MySize.size6),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.grey1,
            fontSize: MySize.size10,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProductWidget extends StatelessWidget {
  const CustomProductWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Row(
      children: [
        Container(
          width: MySize.size60,
          height: MySize.size60,
          decoration: ShapeDecoration(
            image: const DecorationImage(
              image: AssetImage(imgProducts),
              fit: BoxFit.cover,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(width: MySize.size10),
        Expanded(
          child: Column(
            children: [
              Text(
                'Shirt Signed by Falcons',
                style: TextStyle(
                  color: ThemeColors.bgColor,
                  fontSize: MySize.size12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(icDigital),
                  SizedBox(width: MySize.size4),
                  Text(
                    'Digital',
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: MySize.size16),
                  SvgPicture.asset(icTshirt),
                  SizedBox(width: MySize.size4),
                  Text(
                    '13 Left',
                    style: TextStyle(
                      color: ThemeColors.green,
                      fontSize: MySize.size10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            FlexibleButton(
              height: MySize.size14,
              width: MySize.size20,
              backgroundColor: ThemeColors.bgColor.withOpacity(0.25),
              text: "Get",
              textColor: ThemeColors.green,
              textSize: MySize.size10,
              weight: FontWeight.w500,
              radius: 10,
              onPressed: () {},
            ),
            SizedBox(height: MySize.size2),
            Text(
              '1,30,000 PPT',
              style: TextStyle(
                color: ThemeColors.bgColor,
                fontSize: MySize.size10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

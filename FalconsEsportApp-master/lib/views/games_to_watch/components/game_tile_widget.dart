import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GameTileWidget extends StatelessWidget {
  const GameTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: MySize.size60,
                    height: MySize.size60,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(imgPubg),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x2B18B35B),
                          blurRadius: 15,
                          offset: Offset(0, 8),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: Spacing.all(MySize.size2),
                    child: Container(
                      width: MySize.size20,
                      height: MySize.size20,
                      decoration: ShapeDecoration(
                        color: ThemeColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(icStream),
                    ),
                  ),
                ],
              ),
              SizedBox(width: MySize.size10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Falcons Live Stream',
                    style: TextStyle(
                      color: ThemeColors.bgColor,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MySize.size50,
                        height: MySize.size20,
                        child: Stack(
                          children: [
                            Container(
                              width: MySize.size17,
                              height: MySize.size17,
                              decoration: const ShapeDecoration(
                                color: ThemeColors.bgColor,
                                shape: OvalBorder(
                                  side: BorderSide(
                                      width: 0.50, color: Color(0xFF18B35B)),
                                ),
                              ),
                            ),
                            Positioned(
                              left: MySize.size9,
                              child: Container(
                                width: MySize.size17,
                                height: MySize.size17,
                                decoration: const ShapeDecoration(
                                  color: Colors.blue,
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFF18B35B)),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: MySize.size18,
                              child: Container(
                                width: MySize.size17,
                                height: MySize.size17,
                                decoration: const ShapeDecoration(
                                  color: Colors.red,
                                  shape: OvalBorder(
                                    side: BorderSide(
                                      width: 0.50,
                                      color: Color(0xFF18B35B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: MySize.size27,
                              child: Container(
                                width: MySize.size17,
                                height: MySize.size17,
                                decoration: const ShapeDecoration(
                                  color: Colors.black,
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 0.50, color: Color(0xFF18B35B)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: MySize.size1),
                      Text(
                        '4+',
                        style: TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: MySize.size10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              FlexibleButton(
                height: MySize.size20,
                width: MySize.size53,
                backgroundColor: ThemeColors.bgColor.withOpacity(0.25),
                text: "Watch",
                textColor: ThemeColors.green,
                textSize: MySize.size10,
                weight: FontWeight.w500,
                radius: 10,
                onPressed: () {},
              ),
              SizedBox(height: MySize.size10),
              Text(
                '83.5K Views',
                style: TextStyle(
                  color: ThemeColors.bgColor.withOpacity(0.25),
                  fontSize: MySize.size10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

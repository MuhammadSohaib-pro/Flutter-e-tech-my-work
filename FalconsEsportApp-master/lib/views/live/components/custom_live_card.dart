import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLiveCard extends StatelessWidget {
  const CustomLiveCard({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: MySize.size207,
        decoration: ShapeDecoration(
          image: const DecorationImage(
            image: AssetImage(imgPubgLive),
            fit: BoxFit.fill,
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
                padding: Spacing.horizontal(MySize.size10),
                child: Row(
                  children: [
                    Container(
                      width: MySize.size42,
                      height: MySize.size42,
                      decoration: const ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgPerson),
                          fit: BoxFit.cover,
                        ),
                        shape: CircleBorder(),
                        shadows: [
                          BoxShadow(
                            color: Color(0x2B18B35B),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: MySize.size10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Twitch Live Stream',
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
                                    width: MySize.size20,
                                    height: MySize.size20,
                                    decoration: const ShapeDecoration(
                                      color: ThemeColors.bgColor,
                                      image: DecorationImage(
                                        image: AssetImage(imgPerson),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: OvalBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: ThemeColors.black1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 9,
                                    child: Container(
                                      width: MySize.size20,
                                      height: MySize.size20,
                                      decoration: const ShapeDecoration(
                                        color: Colors.blue,
                                        image: DecorationImage(
                                          image: AssetImage(imgPerson),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: OvalBorder(
                                          side: BorderSide(
                                            width: 2,
                                            color: ThemeColors.black1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 18,
                                    child: Container(
                                      width: MySize.size20,
                                      height: MySize.size20,
                                      decoration: const ShapeDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: AssetImage(imgPerson),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: OvalBorder(
                                          side: BorderSide(
                                            width: 2,
                                            color: ThemeColors.black1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 27,
                                    child: Container(
                                      width: MySize.size20,
                                      height: MySize.size20,
                                      decoration: const ShapeDecoration(
                                        color: Colors.black,
                                        image: DecorationImage(
                                          image: AssetImage(imgPerson),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: OvalBorder(
                                          side: BorderSide(
                                              width: 2,
                                              color: ThemeColors.black1),
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
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: Spacing.all(MySize.size10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 56,
                      height: 20,
                      decoration: ShapeDecoration(
                        color: ThemeColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(icStream),
                          SizedBox(width: MySize.size4),
                          Text(
                            'Live',
                            style: TextStyle(
                              color: ThemeColors.bgColor,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MySize.size70,
                      height: MySize.size20,
                      decoration: ShapeDecoration(
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(icUser),
                          SizedBox(width: MySize.size4),
                          Text(
                            '83.5K',
                            style: TextStyle(
                              color: ThemeColors.bgColor,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

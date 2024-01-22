import 'package:event_app/helper/constant.dart';
import 'package:event_app/helper/mySize.dart';
import 'package:event_app/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CstomCartCard extends StatelessWidget {
  const CstomCartCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.fromLTRB(MySize.size32, 0, MySize.size32, MySize.size10),
      child: SizedBox(
        width: double.infinity,
        height: MySize.size90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  child: Container(
                    width: MySize.size20,
                    height: MySize.size20,
                    decoration: ShapeDecoration(
                      color: ThemeColors.fillColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.remove,
                      color: ThemeColors.black1,
                      size: MySize.size10,
                    ),
                  ),
                ),
                SizedBox(width: MySize.size8),
                Text(
                  '1',
                  style: TextStyle(
                    color: ThemeColors.black1,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: MySize.size8),
                InkWell(
                  onTap: () {},
                  overlayColor:
                      const MaterialStatePropertyAll(Colors.transparent),
                  child: Container(
                    width: MySize.size20,
                    height: MySize.size20,
                    decoration: ShapeDecoration(
                      color: ThemeColors.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add,
                      color: ThemeColors.bgColor,
                      size: MySize.size10,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: MySize.size90,
              height: MySize.size90,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 0, width: double.infinity),
                      SizedBox(height: MySize.size22),
                      Expanded(
                        child: Container(
                          width: MySize.size60,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE3C5C5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 20,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MySize.size72,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            image: AssetImage(imgFavoriteFood),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                'Mindy rice with a barbecue dish.',
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: MySize.size14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '1500.00 SAR',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: ThemeColors.grey1,
                    fontSize: MySize.size12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

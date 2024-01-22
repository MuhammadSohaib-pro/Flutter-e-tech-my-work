import 'package:event_app/helper/constant.dart';
import 'package:event_app/helper/mySize.dart';
import 'package:event_app/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CstmKitchenListItemCard extends StatelessWidget {
  const CstmKitchenListItemCard({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Spacing.horizontal(MySize.size32),
      child: InkWell(
        onTap: onPressed,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
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
                SizedBox(width: MySize.size7),
                Container(
                  width: MySize.size70,
                  height: MySize.size84,
                  alignment: Alignment.center,
                  child: Text(
                    'Full Lamb Mandi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MySize.size14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '1500.00 SAR',
              style: TextStyle(
                color: ThemeColors.mainColor,
                fontSize: MySize.size12,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}

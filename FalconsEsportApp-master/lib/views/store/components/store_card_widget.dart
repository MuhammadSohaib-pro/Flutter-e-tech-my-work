import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StoreCardWidget extends StatelessWidget {
  const StoreCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MySize.size140,
          width: MySize.size300,
          child: SvgPicture.asset(icStoreCard),
        ),
        SizedBox(
          width: MySize.size300,
          height: MySize.size140,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: Spacing.left(MySize.size10),
                      child: const Text(
                        'LIQUID X NARUTO ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: MySize.size6),
                    Padding(
                      padding: Spacing.left(MySize.size10),
                      child: Text(
                        'Custom-made, removable hood, contrast mesh lining, inner removable shoulder straps, and pockets throughout. ',
                        style: TextStyle(
                          color: const Color(0xFF005F29),
                          fontSize: MySize.size8,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: MySize.size6),
                    Padding(
                      padding: Spacing.left(MySize.size10),
                      child: FlexibleButton(
                        height: MySize.size20,
                        width: MySize.size75,
                        backgroundColor: ThemeColors.mainColor,
                        text: "Buy Now",
                        textColor: ThemeColors.bgColor,
                        textSize: MySize.size10,
                        weight: FontWeight.w500,
                        radius: 10,
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(height: MySize.size18),
                  ],
                ),
              ),
              SizedBox(width: MySize.size10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MySize.size110,
                    height: MySize.size98,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: AssetImage(imgValorant),
                        fit: BoxFit.fill,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: MySize.size10),
            ],
          ),
        )
      ],
    );
  }
}

import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:flutter/material.dart';

class CustomGamesWidget extends StatelessWidget {
  const CustomGamesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(height: MySize.size9, width: MySize.size155),
            Container(
              width: MySize.size136,
              height: MySize.size205,
              decoration: ShapeDecoration(
                color: const Color(0x19D9D9D9),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 1, color: ThemeColors.green),
                  borderRadius: BorderRadius.circular(15),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Valorant',
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: MySize.size20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: MySize.size2),
                    Text(
                      '97K Viewers',
                      style: TextStyle(
                        color: ThemeColors.green,
                        fontSize: MySize.size12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: MySize.size15),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: MySize.size22,
          top: -0.73,
          child: Transform(
            transform: Matrix4.identity()
              ..translate(0.0, 0.0)
              ..rotateZ(0.18),
            child: Container(
              width: MySize.size130,
              height: MySize.size130,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(imgValorant),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

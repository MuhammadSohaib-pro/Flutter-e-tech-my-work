import 'package:flutter/material.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/widgets/custom_buttons.dart';


class CustomEmployeeCard extends StatelessWidget {
  const CustomEmployeeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 100,
            margin: const EdgeInsets.fromLTRB(33, 20, 33, 0),
            decoration: const ShapeDecoration(
              color: Color(0xFF6D6865),
              image: DecorationImage(
                  image: AssetImage(imgAddEarningContainer),
                  fit: BoxFit.fill),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              shadows: [
                BoxShadow(
                  color: Color(0x2B000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: ShapeDecoration(
                    color: Colors.amberAccent.shade100,
                    shape: const CircleBorder(),
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Mr. Derek',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                  width: 70,
                  child: CustomButton8(
                    text: "Engage",
                    onPressed: () {},
                    radius: 10,
                    backgroundColor: ThemeColors.yellow,
                    textColor: ThemeColors.bgColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

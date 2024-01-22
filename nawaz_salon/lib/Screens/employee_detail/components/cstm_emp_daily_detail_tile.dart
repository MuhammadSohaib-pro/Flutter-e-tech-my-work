import 'package:flutter/material.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class CustomEmpDailyDetailTile extends StatelessWidget {
  const CustomEmpDailyDetailTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 58,
            margin: const EdgeInsets.fromLTRB(33, 8, 33, 8),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: const BoxDecoration(
              color: ThemeColors.grey4,
              boxShadow: [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thursday',
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '12 Sep,2023',
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rs.10,879.00',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Rs.200.00 Commission',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

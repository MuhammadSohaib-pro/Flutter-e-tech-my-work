import 'package:flutter/material.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class CustomHomeListViewCard extends StatelessWidget {
  const CustomHomeListViewCard({
    super.key,
    required this.topFlag,
    required this.name,
    required this.price,
    required this.commission,
  });
  final bool topFlag;
  final String name;
  final String price;
  final String commission;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(33, 0, 33, 15),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: ThemeColors.grey3))),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: ShapeDecoration(
              color: Colors.amberAccent.shade100,
              shape: const CircleBorder(),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topFlag
                        ? const Text(
                            'Top',
                            style: TextStyle(
                              color: ThemeColors.yellow,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 3),
                    Text(
                      name,
                      style: const TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      commission,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

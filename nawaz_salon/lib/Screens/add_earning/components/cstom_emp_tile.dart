import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class CustomEmpListViewTile extends StatelessWidget {
  const CustomEmpListViewTile({
    super.key,
    required this.name,
    required this.image,
    required this.onPressed, required this.suffixIcon, required this.price,
  });

  final String name;
  final String image;
  final String suffixIcon;
  final String price;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(33, 0, 33, 10),
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
                    const Text(
                      'Top Performer',
                      style: TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      name,
                      style: const TextStyle(
                        color: ThemeColors.bgColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      price,
                      style: const TextStyle(
                        color: ThemeColors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: onPressed,
                      child: SvgPicture.asset(suffixIcon),
                    ),
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

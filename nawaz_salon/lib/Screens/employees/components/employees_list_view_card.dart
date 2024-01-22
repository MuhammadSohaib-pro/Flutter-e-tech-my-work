import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';

class CustomEmployeesListViewCard extends StatelessWidget {
  const CustomEmployeesListViewCard({
    super.key, required this.name, required this.image, required this.onPressed,
  });

  final String name;
  final String image;
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
                GestureDetector(
                  onTap: onPressed,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          color: ThemeColors.bgColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        "Active",
                        style: TextStyle(
                          color: ThemeColors.yellow,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCustomBottomSheet(context);
                        print("menu");
                      },
                      child: SvgPicture.asset(icMenu),
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

  showCustomBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: GestureDetector(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                height: 170,
                decoration: const BoxDecoration(
                  color: ThemeColors.bgColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Delete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    //Active
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Deactivate',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Edit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ThemeColors.black1,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

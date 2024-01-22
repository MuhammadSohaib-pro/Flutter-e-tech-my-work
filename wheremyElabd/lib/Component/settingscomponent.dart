import 'package:flutter/material.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class SettingsComponent extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Function()? onTap;

  const SettingsComponent({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 363,
        height: 70,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children:[ Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                title== 'Delete Account' ?Icon(
                  icon,
                  color: Colors.red,
                  size: 30,
                ):Icon(
                  icon,
                  color: Colors.blue,
                  size: 30,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      subtitle,
                      style: MyTextStyles.settingsGrey(11.0)
                    ),
                    Text(
                      title,
                      style:title== 'Delete Account' ?MyTextStyles.settingsRedlit :MyTextStyles.settingsblacklit,
                    ),
                  ],
                ),

              ],
            ),

          ),
            const SizedBox(height: 2,),
            Container(
              width: 365,
              height: 1,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
      ],
        ),
      ),
    );
  }
}

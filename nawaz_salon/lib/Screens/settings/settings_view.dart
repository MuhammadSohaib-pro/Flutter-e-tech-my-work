import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/Screens/profile/profile_view.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/widgets/scrollable_column.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return ScrollableColumn(
      children: [
        Container(
          height: 110,
          width: 110,
          margin: const EdgeInsets.fromLTRB(0, 80, 0, 12),
          decoration: const ShapeDecoration(
            image: DecorationImage(
                image: AssetImage(imgSettingCircle), fit: BoxFit.fill),
            shape: CircleBorder(),
          ),
          child: const Icon(
            Icons.storefront_outlined,
            color: ThemeColors.bgColor,
            size: 45,
          ),
        ),
        const Text(
          'NAWAZ SALOON',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ThemeColors.bgColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(icEdit),
              const SizedBox(width: 5),
              const Text(
                'EDIT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeColors.yellow,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(33, 0, 33, 10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileView(),),);
                  },
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2E2B37),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFF454053)),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(icProfile),
                        const SizedBox(height: 7),
                        const Text(
                          'Profile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2E2B37),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFF454053)),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(icTermsConditions),
                        const SizedBox(height: 7),
                        const Text(
                          'Terms & Conditions',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(33, 0, 33, 30),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2E2B37),
                      shape: RoundedRectangleBorder(
                        side:
                            const BorderSide(width: 1, color: Color(0xFF454053)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(icPrivacyPolicy),
                        const SizedBox(height: 7),
                        const Text(
                          'Privacy Policy',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF2E2B37),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFF454053)),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(icClose),
                        const SizedBox(height: 7),
                        const Text(
                          'Logout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemeColors.yellow,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

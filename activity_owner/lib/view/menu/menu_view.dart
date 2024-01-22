import 'package:activity_owner/helper/constant.dart';
import 'package:activity_owner/helper/mySize.dart';
import 'package:activity_owner/helper/theme_helper.dart';
import 'package:activity_owner/view/about_us/about_us_view.dart';
import 'package:activity_owner/view/menu/components/menu_card.dart';
import 'package:activity_owner/view/privacy_policy/privacy_policy_view.dart';
import 'package:activity_owner/view/profile/profile_view.dart';
import 'package:activity_owner/view/settings/settings.dart';
import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MySize.size320,
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(imgCircleHalf),
                          alignment: Alignment.topLeft),
                    ),
                    child: Container(
                      height: MySize.size180,
                      width: MySize.size180,
                      decoration: const BoxDecoration(
                        color: Color(0xffeeeffe),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        height: MySize.size140,
                        width: MySize.size140,
                        decoration: const BoxDecoration(
                          color: Color(0xffe2e4fc),
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: MySize.size48,
                          backgroundColor: Colors.lightGreen,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size6),
                  Center(
                    child: Text(
                      'John Wick',
                      style: TextStyle(
                        color: ThemeColors.mainColor,
                        fontSize: MySize.size16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '104',
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "My Activities",
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: MySize.size95),
                      Column(
                        children: [
                          Text(
                            "50",
                            style: TextStyle(
                              color: ThemeColors.black1,
                              fontSize: MySize.size24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "My Bookings",
                            style: TextStyle(
                              color: ThemeColors.grey1,
                              fontSize: MySize.size10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.size70),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: Text(
                      'Profile & Information',
                      style: TextStyle(
                        color: ThemeColors.mainDark,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size10),
                  MenuCard(
                    icon: icPerson,
                    title: "Profile",
                    subtitle: "Personal Information, Profile Picture",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: MySize.size10),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: Text(
                      'Wallet',
                      style: TextStyle(
                        color: ThemeColors.mainDark,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size10),
                  MenuCard(
                    icon: icWalletOutlined,
                    title: "Wallet",
                    subtitle: "Bank Account, Receiving & Withdraw History",
                    onPressed: () {},
                  ),
                  SizedBox(height: MySize.size10),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        color: ThemeColors.mainDark,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size10),
                  MenuCard(
                    icon: icSettings,
                    title: "Settings",
                    subtitle: "Notification, Language, Delete Account, Logout",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: MySize.size10),
                  Padding(
                    padding: Spacing.horizontal(MySize.size32),
                    child: Text(
                      'Policies & About Us',
                      style: TextStyle(
                        color: ThemeColors.mainDark,
                        fontSize: MySize.size14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.size10),
                  MenuCard(
                    icon: icKeyHole,
                    title: "Privacy Policy & Terms",
                    subtitle: "",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: MySize.size10),
                  MenuCard(
                    icon: icInfo,
                    title: "About Us",
                    subtitle: "",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsView(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: MySize.size30),
                ],
              ),
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: ThemeColors.bgColor),
                  ),
                  title: Text(
                    'Menu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ThemeColors.bgColor,
                      fontSize: MySize.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawaz_salon/Screens/add_earning/add_earning_view.dart';
import 'package:nawaz_salon/Screens/employees/employees_view.dart';
import 'package:nawaz_salon/Screens/home/home_view.dart';
import 'package:nawaz_salon/Screens/manage_earning/manage_earning_view.dart';
import 'package:nawaz_salon/Screens/settings/settings_view.dart';
import 'package:nawaz_salon/helper/constant.dart';
import 'package:nawaz_salon/helper/theme_helper.dart';
import 'package:nawaz_salon/providers/bottom_nav_%20bar_provider.dart';
import 'package:provider/provider.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

List<Widget> screenList = [
  const HomeView(),
  const EmployeesView(),
  const ManageEarningView(),
  const SettingsView(),
  const AddEarningView(),
];

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, provider, child) => Scaffold(
        backgroundColor: ThemeColors.mainColor,
        appBar: AppBar(
          backgroundColor: ThemeColors.bgColor,
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          centerTitle: true,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: 141,
              height: 64,
              child: SvgPicture.asset(imgLogo),
            ),
          ),
        ),
        body: screenList[provider.bottomIndex],

        // bottomNavigationBar: AnimatedBottomNavigationBar(
        //   barColor: ThemeColors.bgColor,
        //   controller:
        //       FloatingBottomBarController(initialIndex: provider.bottomIndex),
        //   bottomBar: [
        //     BottomBarItem(
        //       icon: SvgPicture.asset(
        //         icHome,
        //         color: ThemeColors.grey3,
        //       ),
        //       iconSelected: SvgPicture.asset(
        //         icHome,
        //         color: ThemeColors.yellow,
        //       ),
        //       title: "Home",
        //       titleStyle: const TextStyle(
        //         color: Color(0xFF848797),
        //         fontSize: 12,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       dotColor: ThemeColors.yellow,
        //       onTap: (value) {
        //         provider.setBottomIndexValue(0);
        //       },
        //     ),
        //     BottomBarItem(
        //       icon: SvgPicture.asset(
        //         icUser,
        //         color: ThemeColors.grey3,
        //       ),
        //       iconSelected: SvgPicture.asset(
        //         icUser,
        //         color: ThemeColors.yellow,
        //       ),
        //       title: "Employee",titleStyle: const TextStyle(
        //         color: Color(0xFF848797),
        //         fontSize: 12,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       dotColor: ThemeColors.yellow,
        //       onTap: (value) {
        //         provider.setBottomIndexValue(1);
        //       },
        //     ),
        //     BottomBarItem(
        //       icon: SvgPicture.asset(
        //         icCard,
        //         color: ThemeColors.grey3,
        //       ),
        //       iconSelected: SvgPicture.asset(
        //         icCard,
        //         color: ThemeColors.yellow,
        //       ),
        //       title: 'Earning',titleStyle: const TextStyle(
        //         color: Color(0xFF848797),
        //         fontSize: 12,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       dotColor: ThemeColors.yellow,
        //       onTap: (value) {
        //         provider.setBottomIndexValue(2);
        //       },
        //     ),
        //     BottomBarItem(
        //       icon: SvgPicture.asset(
        //         icSetting,
        //         color: ThemeColors.grey3,
        //       ),
        //       iconSelected: SvgPicture.asset(
        //         icSetting,
        //         color: ThemeColors.yellow,
        //       ),
        //       title: 'Settings',titleStyle: const TextStyle(
        //         color: Color(0xFF848797),
        //         fontSize: 12,
        //         fontWeight: FontWeight.w500,
        //       ),
        //       dotColor: ThemeColors.yellow,
        //       onTap: (value) {
        //         provider.setBottomIndexValue(3);
        //       },
        //     ),
        //   ],
        //   bottomBarCenterModel: BottomBarCenterModel(
        //     centerBackgroundColor: ThemeColors.yellow,
        //     centerIcon: FloatingCenterButton(
        //       child: GestureDetector(
        //           onTap: () {
        //             provider.setBottomIndexValue(4);
        //           },
        //           child: SvgPicture.asset(icAdd, height: 28, width: 28)),
        //     ),
        //     centerIconChild: [],
        //   ),
        // ),

        bottomNavigationBar: Container(
          height: 115,
          decoration: const BoxDecoration(
            color: ThemeColors.bgColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        provider.setBottomIndexValue(0);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icHome,
                            color: provider.bottomIndex == 0
                                ? ThemeColors.yellow
                                : ThemeColors.grey3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                color: provider.bottomIndex == 0
                                    ? ThemeColors.yellow
                                    : ThemeColors.grey3,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.setBottomIndexValue(1);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icUser,
                            color: provider.bottomIndex == 1
                                ? ThemeColors.yellow
                                : ThemeColors.grey3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Employee',
                              style: TextStyle(
                                color: provider.bottomIndex == 1
                                    ? ThemeColors.yellow
                                    : ThemeColors.grey3,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 5),
                  Container(
                    height: 70,
                    width: 74,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: ThemeColors.bgColor,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        FloatingActionButton(
                          onPressed: () {
                            provider.setBottomIndexValue(4);
                          },
                          backgroundColor: ThemeColors.yellow,
                          child: SvgPicture.asset(icAdd, height: 28, width: 28),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        provider.setBottomIndexValue(2);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icCard,
                            color: provider.bottomIndex == 2
                                ? ThemeColors.yellow
                                : ThemeColors.grey3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Earning',
                              style: TextStyle(
                                color: provider.bottomIndex == 2
                                    ? ThemeColors.yellow
                                    : ThemeColors.grey3,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        provider.setBottomIndexValue(3);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icSetting,
                            color: provider.bottomIndex == 3
                                ? ThemeColors.yellow
                                : ThemeColors.grey3,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              'Settings',
                              style: TextStyle(
                                color: provider.bottomIndex == 3
                                    ? ThemeColors.yellow
                                    : ThemeColors.grey3,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // bottomNavigationBar: BottomNavigationBar(
        //   showUnselectedLabels: true,
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Colors.amber,
        //   unselectedItemColor: ThemeColors.grey3,
        //   selectedLabelStyle: const TextStyle(color: ThemeColors.yellow,fontSize: 12),
        //   unselectedLabelStyle: const TextStyle(color: ThemeColors.grey3,fontSize: 12),
        //   currentIndex: 0,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: SvgPicture.asset(
        //         icHome,
        //         color: ThemeColors.grey3,
        //       ),
        //       activeIcon: SvgPicture.asset(
        //         icUser,
        //         color: ThemeColors.yellow,
        //       ),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: SvgPicture.asset(icUser),
        //       activeIcon: SvgPicture.asset(
        //         icUser,
        //         color: ThemeColors.yellow,
        //       ),
        //       label: 'Employee',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: SvgPicture.asset(icCard),
        //       activeIcon: SvgPicture.asset(
        //         icCard,
        //         color: ThemeColors.yellow,
        //       ),
        //       label: 'Earning',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: SvgPicture.asset(icSetting),
        //       activeIcon: SvgPicture.asset(
        //         icSetting,
        //         color: ThemeColors.yellow,
        //       ),
        //       label: 'Setting',
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

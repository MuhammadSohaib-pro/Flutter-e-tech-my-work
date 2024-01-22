// ignore_for_file: deprecated_member_use

import 'package:falconsesportsapp/helper/constant.dart';
import 'package:falconsesportsapp/helper/mySize.dart';
import 'package:falconsesportsapp/helper/theme_helper.dart';
import 'package:falconsesportsapp/views/bottom_nav_bar/bottom_nav_bar_provider.dart';
import 'package:falconsesportsapp/views/home/home_view.dart';
import 'package:falconsesportsapp/views/live/live_view.dart';
import 'package:falconsesportsapp/views/quests/quests_view.dart';
import 'package:falconsesportsapp/views/rewards/rewards_view.dart';
import 'package:falconsesportsapp/views/store/store_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: ThemeColors.mainColor,
      body: Consumer<BottomNavBarProvider>(
        builder: (context, p, child) => SafeArea(
          child: screenList[p.bottomIndex],
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavBarProvider>(
        builder: (context, p, child) => BottomNavigationBar(
          onTap: (value) {
            p.changeBottomIndexValue(value);
          },
          currentIndex: p.bottomIndex,
          selectedItemColor: ThemeColors.green,
          unselectedItemColor: ThemeColors.grey3,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(
            fontSize: MySize.size10,
            fontWeight: FontWeight.w400,
          ),
          selectedLabelStyle: TextStyle(
            fontSize: MySize.size10,
            fontWeight: FontWeight.w400,
          ),
          // backgroundColor: ThemeColors.mainColor,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: Spacing.all(MySize.size5),
                child: SvgPicture.asset(
                  p.bottomIndex == 0 ? icExploreFill : icExplore,
                  color: p.bottomIndex == 0
                      ? ThemeColors.green
                      : ThemeColors.grey3,
                ),
              ),
              label: "Explore",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: Spacing.all(MySize.size5),
                child: SvgPicture.asset(
                  p.bottomIndex == 1 ? icLiveFill : icLive,
                  color: p.bottomIndex == 1
                      ? ThemeColors.green
                      : ThemeColors.grey3,
                ),
              ),
              label: "Live",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: Spacing.all(MySize.size5),
                child: SvgPicture.asset(
                  p.bottomIndex == 2 ? icQuestsFill : icQuests,
                  color: p.bottomIndex == 2
                      ? ThemeColors.green
                      : ThemeColors.grey3,
                ),
              ),
              label: "Quests",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: Spacing.all(MySize.size5),
                child: SvgPicture.asset(
                  p.bottomIndex == 3 ? icReward : icRewardOutlined,
                  color: p.bottomIndex == 3
                      ? ThemeColors.green
                      : ThemeColors.grey3,
                ),
              ),
              label: "Rewards",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: Spacing.all(MySize.size5),
                child: SvgPicture.asset(
                  p.bottomIndex == 4 ? icStoreFill : icStore,
                  color: p.bottomIndex == 4
                      ? ThemeColors.green
                      : ThemeColors.grey3,
                ),
              ),
              label: "Store",
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> screenList = [
    const HomeView(),
    const LiveView(),
    const QuestsView(),
    const RewardsView(),
    const StoreView(),
  ];
}

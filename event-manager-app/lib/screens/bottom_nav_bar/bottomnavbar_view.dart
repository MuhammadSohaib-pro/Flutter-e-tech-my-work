// ignore_for_file: deprecated_member_use

import 'package:event_manager_app/helper/exports.dart';
import 'package:event_manager_app/screens/bottom_nav_bar/bottomnavbar_provider.dart';
import 'package:event_manager_app/screens/home/home_view.dart';
import 'package:event_manager_app/screens/orders/orders_view.dart';
import 'package:event_manager_app/screens/wallet/wallet_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({super.key});

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

List<Widget> drawerScreens = [
  const HomeView(),
  const OrdersView(),
  const WalletView(),
];
int index = 0;

class _BottomNavBarViewState extends State<BottomNavBarView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      body: SafeArea(
        child: Consumer<BottomNavBarProvider>(
          builder: (context, p, child) => drawerScreens[p.bottomIndex],
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavBarProvider>(
        builder: (context, p, child) => BottomNavigationBar(
          currentIndex: p.bottomIndex,
          onTap: (value) => p.setBottomIndex(value),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(
            color: ThemeColors.mainColor,
            fontSize: MySize.size12,
            fontWeight: FontWeight.w500,
          ),
          selectedItemColor: ThemeColors.mainColor,
          unselectedItemColor: ThemeColors.grey1,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(
            color: ThemeColors.grey1,
            fontSize: MySize.size12,
            fontWeight: FontWeight.w500,
          ),
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icHome,
                  color: ThemeColors.grey1,
                ),
              ),
              activeIcon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icHome,
                  color: ThemeColors.mainColor,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icOrderFilled,
                  color: ThemeColors.grey1,
                ),
              ),
              activeIcon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icOrderFilled,
                  color: ThemeColors.mainColor,
                ),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icWalletFilled,
                  color: ThemeColors.grey1,
                ),
              ),
              activeIcon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icWalletFilled,
                  color: ThemeColors.mainColor,
                ),
              ),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}

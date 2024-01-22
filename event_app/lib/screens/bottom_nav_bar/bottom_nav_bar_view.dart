// ignore_for_file: deprecated_member_use
import 'package:event_app/helper/imports.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (context, provider, child) => Scaffold(
        body: SafeArea(
          child: bodyList[provider.bottomIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: provider.bottomIndex,
          onTap: (value) => provider.setBottomIndex(value),
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
              label: AppLocalizations.of(context)!.home.toString(),
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icFavourites,
                  color: ThemeColors.grey1,
                ),
              ),
              activeIcon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icFavourites,
                  color: ThemeColors.mainColor,
                ),
              ),
              label: AppLocalizations.of(context)!.favorites.toString(),
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icOrders,
                  color: ThemeColors.grey1,
                ),
              ),
              activeIcon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icOrders,
                  color: ThemeColors.mainColor,
                ),
              ),
              label: AppLocalizations.of(context)!.orders.toString(),
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icMenu,
                  color: ThemeColors.grey1,
                ),
              ),
              activeIcon: SizedBox(
                height: MySize.size24,
                width: MySize.size24,
                child: SvgPicture.asset(
                  icMenu,
                  color: ThemeColors.mainColor,
                ),
              ),
              label: AppLocalizations.of(context)!.menu.toString(),
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> bodyList = [
  const HomeView(),
  const FavoriteView(),
  const OrderView(),
  const MenuView()
];

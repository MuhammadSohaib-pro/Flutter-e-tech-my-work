import 'package:activityapp/global/layout/padding_screen.dart';
import 'package:activityapp/screens/booking_screens/booking_screen.dart';
import 'package:activityapp/screens/favrouite_screens/favrouite_screen.dart';
import 'package:activityapp/screens/home/home_screen.dart';
import 'package:activityapp/screens/search_screen/searching_screen.dart';
import 'package:activityapp/screens/settings/menu_screen.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> with TickerProviderStateMixin {
  var _selectedTab = _SelectedTab.home;

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,

      //backgroundColor: Colors.black,
      body: IndexedStack(
          index: _SelectedTab.values.indexOf(_selectedTab),
          children: [
             HomeScreen(),
             BookingScreen(),
            SearchingScreen(),
            FavrouiteScreen(),
            // Menu(),

          ],
        ),
      bottomNavigationBar:
      DotNavigationBar(
        margin:  EdgeInsets.only(top: 50),
        marginR: MyEdgeInsets.home1,//EdgeInsets.symmetric(horizontal: 20, vertical: 10),

        //      paddingR = const EdgeInsets.only(bottom: 5, top: 10),
        //margin:EdgeInsets.only(left: 0, right: 0,top: 0,bottom: 0),
        paddingR: const EdgeInsets.only( top: 0),
        backgroundColor: const Color(0xFF0D1632),
        currentIndex: _SelectedTab.values.indexOf(_selectedTab),
        dotIndicatorColor: const Color(0xFF2538E8),
        unselectedItemColor: Colors.grey[300],
        splashBorderRadius: 50,
        enableFloatingNavBar: true,
        onTap: _handleIndexChanged,
        items: [
          DotNavigationBarItem(
            icon: _selectedTab == _SelectedTab.home
                ? Image.asset('assets/images/homefil.png',scale: 2,)
                :  Image.asset('assets/images/homeunfil.png',scale: 2),
            selectedColor: Colors.white,
          ),
          DotNavigationBarItem(
            icon: _selectedTab == _SelectedTab.shopping
                ? Image.asset('assets/images/ShoppingBagfil.png',scale: 2)
                : Image.asset('assets/images/ShoppingBag.png',scale: 2),
            selectedColor: Colors.white,
          ),
          DotNavigationBarItem(
            icon: _selectedTab == _SelectedTab.search
                ? Image.asset('assets/images/searchfill.png',scale: 2)
                : Image.asset('assets/images/searchunfill.png',scale: 2),
            selectedColor: Colors.white,
          ),
          DotNavigationBarItem(
            icon: _selectedTab == _SelectedTab.favorite
                ? Image.asset('assets/images/heartfill.png',scale: 2)
                : Image.asset('assets/images/Heartunfil.png',scale: 2),
            selectedColor: Colors.white,
          ),
          // DotNavigationBarItem(
          //   icon: _selectedTab == _SelectedTab.settings
          //       ? Image.asset('assets/images/heartfill.png',scale: 2)
          //       : Image.asset('assets/images/Heartunfil.png',scale: 2),
          //   selectedColor: Colors.white,
          // ),

        ],
      ),
    );
  }
}

enum _SelectedTab { home,shopping, search,favorite  }

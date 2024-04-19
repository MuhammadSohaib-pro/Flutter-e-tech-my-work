//
//
// import 'dart:ui';
//
// import 'package:boat_app/view/home_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../provider/BottomBarUser_provider.dart';
// import '../utils/colors.dart';
// import '../utils/image_paths.dart';
// import '../utils/onPopScope.dart';
// import 'home/home_screen.dart';
//
// class BottomNavigationBarH extends StatefulWidget {
//   const BottomNavigationBarH(
//       {super.key, });
//
//   @override
//   State<BottomNavigationBarH> createState() => _BottomNavigationBarHState();
// }
//
// class _BottomNavigationBarHState extends State<BottomNavigationBarH> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//
//   void _onItemTapped(int index) {
//     bottomBarUserProvider provider =
//     Provider.of<bottomBarUserProvider>(context, listen: false);
//     provider.updateSelectedIndex(index);
//     _selectedIndex = provider.selectedIndex;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     bottomBarUserProvider provider =
//     Provider.of<bottomBarUserProvider>(context);
//     final List<Widget> _widgetOptions = <Widget>[
//       Offers_screen(),
//     Offers_screen(),
//       HomeScreen(
//       ),
//       Offers_screen(),
//       HomeScreen(
//       ),
//
//     ];
//     return WillPopScope(
//       onWillPop: () async {
//         return exitApp(context);
//       },
//       child: Scaffold(
//         floatingActionButton: Container(
//           height: 76.0,
//           width: 75.0,
//           child: FittedBox(
//             child: FloatingActionButton(
//               backgroundColor: primaryColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(100.0),
//               ),
//               onPressed: () {
//                 // Get.to(Search_screen());
//               },
//               child: Icon(Icons.search, color: Colors.white, size: 25,),
//               // elevation: 5.0,
//             ),
//           ),
//         ),
//
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//
//         body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               activeIcon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
//                 child: Image.asset(home),
//               ),
//               icon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
//                 child: Image.asset(home),
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               activeIcon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
//                 child: Image.asset(fav),
//               ),
//               icon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
//                 child: Image.asset(fav),
//               ),
//               label: '',
//             ),
//
//             BottomNavigationBarItem(
//               activeIcon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
//                 child: Image.asset(booking),
//               ),
//               icon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
//                 child: Image.asset(booking),
//               ),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               activeIcon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
//                 child: Image.asset(profile),
//               ),
//               icon: ColorFiltered(
//                 colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn),
//                 child: Image.asset(profile),
//               ),
//               label: '',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Colors.amber[800],
//           onTap: _onItemTapped,
//         ),
//
//       ),
//     );
//   }
// }

import 'package:boat_app/global.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/view/home/Search/searchScreen.dart';
import 'package:boat_app/view/favorites/favorties.dart';
import 'package:boat_app/view/home/homescreen/home_screen.dart';
import 'package:boat_app/view/settings/settings.dart';
// import 'package:boat_app/view/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../languages/LocaleString.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../my_bookings/my_bookings.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    if(FirebaseAuth.instance.currentUser != null){
      final String uid =  FirebaseAuth.instance.currentUser!.uid;
      notificationServices.sendToken(uid);

    }
    super.initState();
  }

  final List<Widget> _widgetOptions = [
    // Replace these with your own widget options
    const HomeScreen(),
    const Favorties(),
    const Text('Profile'),
    const MyBookings(),
    const SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade300,
          items:  <BottomNavigationBarItem>[
             BottomNavigationBarItem(
               activeIcon: SvgPicture.asset(homesvg, color: primaryColor,),
              icon: SvgPicture.asset(homesvg,color: bottomBarGrey,),
              label: AppLocale.home.getString(context),

            ),
             BottomNavigationBarItem(
               activeIcon: SvgPicture.asset(favsvg, color: primaryColor,),

               icon: SvgPicture.asset(favsvg,color: bottomBarGrey),
              label: AppLocale.favorites.getString(context),
            ),
            BottomNavigationBarItem(

              icon:InkWell(onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>const SearchScreen()));
              },
                child: Container(
                  height: 20,
                ),
              ),
              label: '',
            ),

             BottomNavigationBarItem(
               activeIcon: SvgPicture.asset(bookingsvg, color: primaryColor,),

               icon: SvgPicture.asset(bookingsvg,color: bottomBarGrey),
              label: AppLocale.bookings.getString(context),
            ),
             BottomNavigationBarItem(
               activeIcon: SvgPicture.asset(settings, color: primaryColor,),
               icon: SvgPicture.asset(settings,color: bottomBarGrey),
              label: AppLocale.settings.getString(context),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
        if(FirebaseAuth.instance.currentUser == null){
          idGuest(context);

        }else{
          if (index == 2) {
            // Navigate to Page1
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));

          }
          else {
            // Handle other items
            setState(() {
              checkUserStatusAndLogout(context);

              if (kDebugMode) {
                print(index);
              }
              _selectedIndex = index;
            });
          }
        }

          },
        ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const SearchScreen()));
        },
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: const Icon(Icons.search_sharp, color: Colors.white,),
        // shape: BeveledRectangleBorder,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
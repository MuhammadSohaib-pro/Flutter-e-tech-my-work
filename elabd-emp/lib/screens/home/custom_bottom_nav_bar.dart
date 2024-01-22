import 'dart:io';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_text.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:elabd_tms_app/screens/attendence/attendence_screen.dart';
import 'package:elabd_tms_app/screens/home/home_screen.dart';
import 'package:elabd_tms_app/screens/profile/profile_screen.dart';
import 'package:elabd_tms_app/screens/salary_report/salary_report_screen.dart';
import 'package:elabd_tms_app/screens/task_page/task_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
// import 'package:new_version/new_version.dart';

class CustomizedBottomNavigationBar extends StatefulWidget {
  int? index;
  CustomizedBottomNavigationBar({Key? key, this.index = 0}) : super(key: key);

  @override
  State<CustomizedBottomNavigationBar> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState
    extends State<CustomizedBottomNavigationBar> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    getUserData();
    _checkVersion();
    super.initState();
  }

  Future<void> _checkVersion() async {
    final store = await FirebaseFirestore.instance
        .collection('appVersions')
        .doc('empApp')
        .get();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String currentAppVersionInFirestore = store.get('currentVersion');
    print("PackageInfo Version ::  $version");
    print("FirebaseFirestore data for app Version ${store.data()}");

    if (version != currentAppVersionInFirestore) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text("Update App?"),
          content: Text(
            'A new version of Elabd App is available! Version $currentAppVersionInFirestore is now available. You have $version \n\nWould you like to update it now?',
          ),
          actions: [
            ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.elabdtech.elabd_tms_app');
                  try {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } catch (e) {
                    throw 'Could not launch $url';
                  }
                },
                child: const Text(
                  "UPDATE NOW",
                  style: TextStyle(color: primaryColor),
                )),
          ],
        ),
      );

    }
  }

  Map<String, dynamic> userData = {};

  Future<void> getUserData() async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userSnapshot != null) {
      userData = userSnapshot.data() as Map<String, dynamic>;
    } else {
      print('No Data found for the current user');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOption = [
      const HomeScreen(),
      const TaskScreen(),
      AttendenceScreen(employeeData: userData),
      SalaryReportScreen(employeeData: userData),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return exitDialog(context);
            });
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: onItemTapped,
          selectedItemColor: Colors.black,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/images/home1.png',
                    color: currentIndex == 0
                        ? primaryColor
                        : const Color(0xffD9D9D9),
                    width: 22,
                    height: 22,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/images/manage.png',
                    color: currentIndex == 1
                        ? primaryColor
                        : const Color(0xffD9D9D9),
                    width: 22,
                    height: 22,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset('assets/images/employe.png',
                      color: currentIndex == 2
                          ? primaryColor
                          : const Color(0xffD9D9D9),
                      width: 22,
                      height: 22),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset('assets/images/salaryreport.png',
                      color: currentIndex == 3
                          ? primaryColor
                          : const Color(0xffD9D9D9),
                      width: 22,
                      height: 22),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/images/profile_icon.png',
                    color: currentIndex == 4
                        ? primaryColor
                        : const Color(0xffD9D9D9),
                    width: 22,
                    height: 22,
                  ),
                ),
                label: ''),
          ],
        ),
        body: SafeArea(child: widgetOption[currentIndex]),
        backgroundColor: Colors.grey.shade400,
      ),
    );
  }

  Widget exitDialog(BuildContext context) {
    return CupertinoAlertDialog(
        title: const CustomText(
          text: 'Confirm',
          color: primaryColor,
          fontSize: 24,
        ),
        content: const Column(children: [
          SizedBox(
            height: 20,
          ),
          CustomText(
            text: 'Are you sure want to exit the app',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 10,
          ),
        ]),
        actions: [
          TextButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('Yes')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No')),
        ]);
  }
}

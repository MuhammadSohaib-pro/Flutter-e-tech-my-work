// ignore_for_file: must_be_immutable

// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/view/attendance_view/attendance_view.dart';
import 'package:elabd_ems_admin/view/home_view/home_view.dart';
import 'package:elabd_ems_admin/view/manage_task_view/manage_task_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
// import 'package:upgrader/upgrader.dart';

import '../generate_salary_view/manage_salary.dart';
import '../manage_employe_view/employe_list.dart';

class BottomNavigationBarView extends StatefulWidget {
  int? index;
  BottomNavigationBarView({Key? key, this.index = 0}) : super(key: key);

  @override
  State<BottomNavigationBarView> createState() =>
      _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState extends State<BottomNavigationBarView> {
  int currentIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> widgetOption = [
    const HomeView(),
    const ManageTaskView(isLeadingIcon: false),
    const AttendanceView(),
    const EmployeList(isLeadingIcon: false),
    ManageSalary(),
  ];

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    _checkVersion();
    super.initState();
  }

  Future<void> _checkVersion() async {
    final store = await FirebaseFirestore.instance
        .collection('appVersions')
        .doc('adminApp')
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
            'A new version of Elabd Admin is available! Version $currentAppVersionInFirestore is now available. You have $version \n\nWould you like to update it now?',
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.elabdtech.elabd_ems_admin');
                try {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } catch (e) {
                  throw 'Could not launch $url';
                }
              },
              child: const Text(
                "UPDATE NOW",
                style: TextStyle(color: primaryColor),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
      // child: UpgradeAlert(
      //   upgrader: Upgrader(
      //     dialogStyle: Platform.isIOS
      //         ? UpgradeDialogStyle.cupertino
      //         : UpgradeDialogStyle.material,
      //     showIgnore: false,
      //     showLater: false,
      //     showReleaseNotes: true,
      //     shouldPopScope: () => false,
      //     // minAppVersion: "",
      //     debugDisplayAlways: true,
      //     debugLogging: true,
      //   ),
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: whiteColor,
            onTap: onItemTapped,
            selectedItemColor: Colors.black,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Image.asset(
                      AppIcons.home,
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
                      AppIcons.manage,
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
                    child: Image.asset(AppIcons.attendance,
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
                    child: Image.asset(AppIcons.employe,
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
                      AppIcons.profileIcon,
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
          body: widgetOption[currentIndex]),
      // ),
    );
  }

  Widget exitDialog(BuildContext context) {
    return CupertinoAlertDialog(
        title: Text(
          'Confirm',
          style: poppinBold.copyWith(color: primaryColor),
        ),
        content: Column(children: [
          SizedBox(
            height: MySize.size20,
          ),
          Text(
            'Are you sure want to exit the app',
            style: poppineRegular.copyWith(fontSize: MySize.size16),
          ),
          SizedBox(
            height: MySize.size10,
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

// import 'package:elabd_ems_admin/helper/import_helper.dart';
// import 'package:elabd_ems_admin/routes/routes_const.dart';
// import 'package:elabd_ems_admin/view/auth/login_view/login_view.dart';
// import 'package:elabd_ems_admin/view/reset_password/reset_password.dart';
// import 'package:elabd_ems_admin/view/setting_view/components/settings_card.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
//
// // ignore: must_be_immutable
// class SettingView extends StatefulWidget {
//   const SettingView({super.key});
//
//   @override
//   State<SettingView> createState() => _SettingViewState();
// }
//
// class _SettingViewState extends State<SettingView> {
//   bool isNotification = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const AppBarWidget(
//         title: 'Settings',
//       ),
//       body: SafeArea(
//           child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: MySize.size14),
//         child: Column(
//           children: [
//             SettingCard(
//               image: AppIcons.profile,
//               title: 'Profile',
//               traling: Image.asset(
//                 AppIcons.arrowforward,
//                 height: MySize.size18,
//                 width: MySize.size8,
//               ),
//               onTap: () {
//                 Navigator.pushNamed(context, profile);
//               },
//             ),
//             SizedBox(
//               height: MySize.size12,
//             ),
//             SettingCard(
//               image: AppIcons.resetpassword,
//               title: 'Reset Password',
//               traling: Image.asset(
//                 AppIcons.arrowforward,
//                 height: MySize.size18,
//                 width: MySize.size8,
//               ),
//               onTap: () {
//                 // Navigator.pushNamed(context, resetPassword);
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ResetPassword(
//                             email: FirebaseAuth.instance.currentUser!.email!)));
//               },
//             ),
//             SizedBox(
//               height: MySize.size12,
//             ),
//             SettingCard(
//               image: AppIcons.settingnotification,
//               title: 'Notifications',
//               traling: SizedBox(
//                 height: MySize.size34,
//                 width: MySize.size44,
//                 child: FittedBox(
//                   fit: BoxFit.fill,
//                   child: Switch(
//                     value: isNotification,
//                     activeTrackColor: primaryColor,
//                     inactiveThumbColor: const Color(0xff3D4859),
//                     inactiveTrackColor: const Color(0xffE5E5E5),
//                     onChanged: (value) {
//                       setState(() {
//                         isNotification = value;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               onTap: () {},
//             ),
//             SizedBox(
//               height: MySize.size12,
//             ),
//             SettingCard(
//               image: AppIcons.logout,
//               title: 'Logout',
//               traling: const SizedBox(),
//               onTap: () {
//                 logOutDialog(context);
//               },
//             ),
//           ],
//         ),
//       )),
//     );
//   }
//
//   void logOutDialog(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return CupertinoAlertDialog(
//             title: Center(
//               child: Text(
//                 "LogOut",
//                 style: poppinBold.copyWith(
//                     fontSize: MySize.size16, color: primaryColor),
//               ),
//             ),
//             content: Column(mainAxisSize: MainAxisSize.min, children: [
//               SizedBox(
//                 height: MySize.size10,
//               ),
//               Text(
//                 'Are You Sure want to LogOut',
//                 style: poppinMedium.copyWith(fontSize: MySize.size12),
//               ),
//               SizedBox(
//                 height: MySize.size40,
//               ),
//             ]),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Cencel')),
//               TextButton(
//                   onPressed: () {
//                     FirebaseAuth.instance.signOut().then((value) {
//                       Navigator.pushReplacement(context,
//                           MaterialPageRoute(builder: (context) => LoginView()));
//                     });
//                   },
//                   child: const Text('Yes')),
//             ],
//           );
//         });
//   }
//
//   // void showLogOutDialog(BuildContext context) {
//   //   showDialog(
//   //       context: context,
//   //       builder: (context) => Dialog(
//   //             shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(MySize.size8),
//   //             ),
//   //             child: Consumer<AuthProvider>(
//   //               builder: (context, provider, _) => SizedBox(
//   //                 height: MySize.scaleFactorHeight * 180,
//   //                 child: Container(
//   //                   decoration: ShapeDecoration(
//   //                       color: whiteColor,
//   //                       shape: RoundedRectangleBorder(
//   //                           borderRadius: BorderRadius.circular(MySize.size8),
//   //                           side: BorderSide.none)),
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.all(12.0),
//   //                     child: Column(
//   //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                       children: [
//   //                         Padding(
//   //                           padding: EdgeInsets.all(MySize.size8),
//   //                           child: Text(
//   //                             "Are You sure You want to Logout!!",
//   //                             style: poppinBold.copyWith(
//   //                                 fontSize: MySize.size16, color: blackColor),
//   //                           ),
//   //                         ),
//   //                         const SizedBox(height: 10),
//   //                         Row(
//   //                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   //                           children: [
//   //                             ButtonComp(
//   //                                 textColor: Colors.white,
//   //                                 title: "No",
//   //                                 backColor: primaryColor,
//   //                                 onTap: () {
//   //                                   Navigator.pop(context);
//   //                                 }),
//   //                             ButtonComp(
//   //                                 textColor: Colors.white,
//   //                                 title: "Yes",
//   //                                 backColor: redColor,
//   //                                 onTap: () async {
//   //                                   provider.signOut().then((value) {
//   //                                     if (value) {
//   //                                       Navigator.pop(context);
//   //                                       Navigator.pushReplacement(context,
//   //                                           MaterialPageRoute(
//   //                                               builder: (context) {
//   //                                         return LoginView();
//   //                                       }));
//   //                                     }
//   //                                   });
//   //                                 })
//   //                           ],
//   //                         ),
//   //                       ],
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //             ),
//   //           ));
//   // }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/view/auth/login_view/login_view.dart';
import 'package:elabd_ems_admin/view/manage_task_view/components/button_comp.dart';
import 'package:elabd_ems_admin/view/profile/web_view_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../profile/edit_profile.dart';
import '../reset_password/reset_password.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';

import 'components/settings_card.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

launchURL() async {
  final Uri url = Uri.parse('https://elabdisb.com/privacy-policy.html');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class _SettingViewState extends State<SettingView> {
  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  Future<void> fetchData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('employees')
        .doc(user?.uid)
        .get();

    if (snapshot.exists) {
      userData = snapshot.data() as Map<String, dynamic>;
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  // bool isNotification = true;
  ValueNotifier<bool> isNotification = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        title: "Settings",
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(MySize.size16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('employees')
                      .doc(user?.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Text('Error fetching data');
                    }

                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return const Text('User data does not exist');
                    }

                    userData = snapshot.data!.data() as Map<String, dynamic>;

                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(userData!['image']),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            userData!['name'],
                            style:
                                poppinMedium.copyWith(fontSize: MySize.size14),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            userData!['email'],
                            style:
                                poppinMedium.copyWith(fontSize: MySize.size14),
                          ),

                          // const SizedBox(
                          //   height: 8,
                          // ),
                          // Text(
                          //   userData!['role'],
                          //   style:
                          //       poppinMedium.copyWith(fontSize: MySize.size14),
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // SizedBox(
              // height: MediaQuery.of(context).size.height * 0.2,
              // child: userData != null
              //     ? Center(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       CircleAvatar(
              //         radius: 30,
              //         backgroundImage: NetworkImage(userData!['image']),
              //       ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Text(
              //         userData!['name'],
              //         style: poppinMedium.copyWith(fontSize: MySize.size14),
              //       ),
              //       const SizedBox(
              //         height: 8,
              //       ),
              //       Text(
              //         userData!['email'],
              //         style: poppinMedium.copyWith(fontSize: MySize.size14),
              //       ),
              //     ],
              //   ),
              // )
              //     :const Center(child: CircularProgressIndicator()),
              // ),
              //
              SizedBox(
                height: MySize.size20,
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(
                height: MySize.size20,
              ),

              Container(
                decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 0,
                          offset: const Offset(2, 2),
                          color: blackColor.withOpacity(0.10))
                    ]),
                child: Center(
                  child: ListTile(
                    onTap: () {},
                    leading: Text(
                      'Notification',
                      style: poppinMedium.copyWith(fontSize: MySize.size14),
                    ),
                    trailing: ValueListenableBuilder(
                      valueListenable: isNotification,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 0.8,
                          child: SizedBox(
                            height: 40,
                            width: 10,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Switch(
                                value: isNotification.value,
                                activeTrackColor: primaryColor,
                                inactiveThumbColor: const Color(0xff3D4859),
                                inactiveTrackColor: const Color(0xffE5E5E5),
                                onChanged: (value) {
                                  isNotification.value = value;
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // SettingCard(
              //   image: AppIcons.settingnotification,
              //   title: 'Notifications',
              //   traling: SizedBox(
              //     height: MySize.size34,
              //     width: MySize.size44,
              //     child: FittedBox(
              //       fit: BoxFit.fill,
              //       child: Switch(
              //         value: isNotification,
              //         activeTrackColor: primaryColor,
              //         inactiveThumbColor: const Color(0xff3D4859),
              //         inactiveTrackColor: const Color(0xffE5E5E5),
              //         onChanged: (value) {
              //           setState(() {
              //             isNotification = value;
              //           });
              //         },
              //       ),
              //     ),
              //   ),
              //   onTap: () {},
              // ),
              SizedBox(
                height: MySize.size20,
              ),
              tileWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfile(
                                  userData: userData,
                                )));
                  },
                  title: 'Edit Profile'),
              tileWidget(
                  onTap: () {
                    launchURL();
                  },
                  title: 'Privacy Policy'),
              tileWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WebViewScreen()));
                  },
                  title: 'Company Policy'),
              tileWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword(
                                  email: userData!['email'],
                                )));
                  },
                  title: 'Reset Password'),
              const SizedBox(
                height: 30,
              ),
              // Center(
              //   child: SizedBox(
              //     width: MySize.screenWidth * 0.3,
              //     child: ButtonComp(
              //       title: 'LogOut',
              //       backColor: redColor.withOpacity(0.50),
              //       onTap: () {
              //         logOutDialog(context);
              //       },
              //     ),
              //   ),
              // ),
              logoutBtn(
                onTap: () {
                  logOutDialog(context);
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget logoutBtn({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(226, 20, 20, 0.18),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                offset: const Offset(2, 2),
                color: blackColor.withOpacity(0.10))
          ],
        ),
        child: const Center(
          child: Text(
            "Logout",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: redColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget tileWidget({String? title, Function? onTap}) {
    return Column(
      children: [
        Container(
          height: 55,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(2, 2),
                    color: blackColor.withOpacity(0.10))
              ]),
          child: Center(
            child: ListTile(
              onTap: onTap as void Function()?,
              leading: Text(
                title!,
                style: poppinMedium.copyWith(fontSize: MySize.size14),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void logOutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "LogOut",
              style: poppinBold.copyWith(
                  fontSize: MySize.size16, color: primaryColor),
            ),
            content: Column(children: [
              SizedBox(
                height: MySize.size10,
              ),
              Text(
                'Are You Sure want to LogOut',
                style: poppinMedium.copyWith(fontSize: MySize.size12),
              ),
              SizedBox(
                height: MySize.size40,
              ),
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    });
                  },
                  child: const Text('Yes')),
            ],
          );
        });
  }
}

import 'package:boat_app/custom_widgets/divider.dart';
import 'package:boat_app/utils/colors.dart';
import 'package:boat_app/utils/constants.dart';
import 'package:boat_app/utils/image_paths.dart';
import 'package:boat_app/utils/sizes_class.dart';
import 'package:boat_app/utils/textstyles.dart';
import 'package:boat_app/view/auth/signin/loginscreen.dart';
import 'package:boat_app/view/settings/help/help_screen.dart';
import 'package:boat_app/view/settings/privacy_policy/privacy_policy.dart';
import 'package:boat_app/view/settings/terms_and_conditions/terms_and_condition.dart';
import 'package:boat_app/view/settings/emergency_screen/update_emergency_screen.dart';
import 'package:boat_app/view/settings/profile/update_profile.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../languages/LocaleString.dart';
import '../../provider/switch_provider.dart';
import '../../utils/sized_box.dart';
import '../../utils/utils.dart';
import '../auth/auth_controller.dart';
import 'emergency_screen/emergency.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  TextEditingController phoneController = TextEditingController();

  String? version;
  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    setState(() {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
    });
  }

  bool notificationSwitch = true;
  final AuthService _authService = AuthService();
  @override
  void initState() {
    getVersion();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final switchProvider = Provider.of<SwitchProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  AppLocale.settings.getString(context),
                  style:  TextStyle(fontSize: MySize2.size16, fontWeight: FontWeight.w600,),
                ),
                SizedBox(
                  height: height(context) * 0.02,
                ),

                //profile
                InkWell(
                  onTap: () async {
                    Map<String ,dynamic>? data = {};


                      data =await fetchDataFromFirebase();





                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfilePage(data: data!,)));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                              profileIcon,color: primaryColor,
                          ),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.profile.getString(context),
                                style: text11400op,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.updateProfile.getString(context),
                                style: text16500,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider_con(),

                //Notifications
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(notifications2,color: primaryColor,),
                        SizedBox(
                          width: width(context) * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocale.getUpdated.getString(context),
                              style: text11400op,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              AppLocale.notification.getString(context),
                              style: text16500,
                            )
                          ],
                        ),
                      ],
                    ),
                    Consumer<SwitchProvider>(builder: (context, value, child) {
                      return FlutterSwitch(
                        activeColor: primaryColor,
                        inactiveColor: const Color(0xffE5E5E5),
                        width: 30.0,
                        height: 20.0,
                        toggleSize: 15.0,
                        value: switchProvider.notificationSwitch,
                        borderRadius: 20.0,
                        padding: 2.0,
                        showOnOff: false,
                        onToggle: (val) {
                          switchProvider.updateNotification(val);

                          notificationSwitch = val;
                          FirebaseFirestore.instance
                              .collection('User')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update({'notification': val});
                        },
                      );
                    })
                  ],
                ),
                const Divider_con(),

                //Language
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                AppLocale.language.getString(context)),
                            content: SizedBox(
                              height: 150,
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: () {
                                      localization.translate('en');
                                      Navigator.pop(context);
                                    },
                                    title: const Text("English"),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      localization.translate('ar');
                                      Navigator.pop(context);
                                    },
                                    title: const Text("Arabic"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                    // Get.find<LocalizationController>().toggleLanguage();
                  },

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(language ,color: primaryColor, ),
                              SizedBox(
                                width: width(context) * 0.04,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocale.language.getString(context),
                                    style: text11400op,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppLocale.language2.getString(context),
                                    style: text16500,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider_con(),

                InkWell(
                  onTap: () async {
                    bool? isSaved = await getEmergencyDetails();
                    if (isSaved == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Emergency()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateEmergencyDetails()));
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.medical_services,
                               color: primaryColor
                          ),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.emergency.getString(context),
                                style: text11400op,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.emergency.getString(context),
                                style: text16500,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider_con(),

                //help
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpScreen()));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(help,color: primaryColor, ),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.needHelp.getString(context),
                                style: text11400op,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.help.getString(context),
                                style: text16500,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider_con(),

                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       onTap: () {
                //         showPhoneInputDialog(context);
                //         if (kDebugMode) {
                //           print(                FirebaseAuth.instance.currentUser!.phoneNumber!
                //         );
                //         }
                //         // Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
                //       },
                //       child: Row(
                //         children: [
                //           SvgPicture.asset(phon, color: primaryColor,),
                //           SizedBox(width: width(context) * 0.04,),
                //
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(AppLocale.phoneNumber.getString(context), style: text11400op,),
                //               const SizedBox(height: 10,),
                //               Text( AppLocale.updatePhone.getString(context), style: text16500,)
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // const Divider_con(),
                // delete profile
                ///
                //delete account
                InkWell(
                  onTap: () async {
                    if (await Utils.checkInternetConnection()) {
                      showDeleteDialog(
                        context,
                      );
                    } else {
                      Utils.showImageDialog(context);
                    }

                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfilePage()));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            profileIcon,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.delete.getString(context),
                                style: text11400op,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.deleteAccount.getString(context),
                                style: text16500,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider_con(),

                //terms and conditions
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TermsAndConditions()));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(terms, color: primaryColor,),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.termsAndConditions.getString(context),
                                style: text11400op,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.termsAndConditions.getString(context),
                                style: text16500,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider_con(),

                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PrivacyPolicy()));
                    // var encoded = Uri.parse('https://www.google.com');
                    // if (await canLaunchUrl(encoded)) {
                    // launchUrl(encoded,
                    //
                    // mode: LaunchMode.externalApplication);
                    // } else {
                    // throw 'Could not launch ';
                    // }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(privacy,color: primaryColor, ),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.privacy.getString(context),
                                style: text11400op,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppLocale.privacy.getString(context),
                                style: text16500,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider_con(),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {},
                      child: Row(
                        children: [
                          SvgPicture.asset(appVersion, color: primaryColor),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.aboutApp.getString(context),
                                style: text11400op,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                version ?? '2.0.0',
                                style: text16500,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider_con(),

                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title:  Text(AppLocale.logOut.getString(context)),
                          content:  Text( AppLocale.areYouYouWantToLogout.getString(context),),
                          actions: [
                            TextButton(
                              child:  Text(AppLocale.cancel.getString(context)),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child:  Text(AppLocale.logOut.getString(context)),
                              onPressed: () {
                                // Perform logout actions here

                                _authService.signOut().then((value) {
                                  if (kDebugMode) {
                                    print('logout');
                                  }
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      LoginView()), (Route<dynamic> route) => false);
                                });
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(logout, color: primaryColor, height: MySize2.size25,),
                          SizedBox(
                            width: width(context) * 0.04,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocale.logOut.getString(context),
                                style: text16500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider_con(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDeleteDialog(
    BuildContext context,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title:  Text(AppLocale.areYouSureDeleteThisAccount.getString(context)),
            content: const Column(
              children: [
                SizedBox(
                  height: 20,
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    // FirebaseFirestore.instance.collection('vehicleType').doc(eventId).delete();

                    deleteAccount();
                    Navigator.pop(context);
                  },
                  child:  Text(AppLocale.delete.getString(context)),),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:  Text(AppLocale.cancel.getString(context)),),
            ],
          );
        });
  }

  void deleteAccount() {
    FirebaseFirestore.instance
        .collection('User')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'deleteTime': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'isDeleted': true,
    }).then((value) async {
      Navigator.pop(context);
      Utils.authErrorSnackbar(
          context, 'Deleted', 'Your account has been deleted');

      await FirebaseAuth.instance.signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
      // _authService.handleSignInWithApple();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
      setState(() {});
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });
  }
  // var Ccode;
  //
  // void showPhoneInputDialog(BuildContext context) {
  //   String initialCountryCode = 'PK';
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) {
  //       return AlertDialog(
  //         title:  Text(AppLocale.updatephoneNumber.getString(context)),
  //         titleTextStyle: const TextStyle(fontSize: 16, color: Colors.black),
  //         content: Container(
  //           height: height(context) * 0.15,
  //
  //           child: Column(
  //             children: [
  //               IntlPhoneField(
  //                 initialCountryCode: initialCountryCode,
  //                 keyboardType: TextInputType.phone,
  //                 controller: phoneController,
  //                 style: const TextStyle(color: Colors.black, fontSize: 14),
  //                 disableLengthCheck: false,
  //                 showCursor: false,
  //                 decoration: InputDecoration(
  //                   prefixIcon: const Icon(Icons.phone),
  //                   hintText: AppLocale.phoneNumber.getString(context),
  //                   hintStyle: const TextStyle(
  //                       color: Color(0xff9FA5C0), fontSize: 14),
  //                   enabledBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(16),
  //                   ),
  //                   focusedBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(16),
  //                     borderSide: const BorderSide(
  //                         color: Colors.deepPurple, width: 2),
  //                   ),
  //                   focusedErrorBorder: OutlineInputBorder(
  //                     borderRadius: BorderRadius.circular(16),
  //                     borderSide: const BorderSide(
  //                         color: Colors.redAccent, width: 2),
  //                   ),
  //                 ),
  //                 onChanged: (phone) {
  //                   Ccode = phone.countryCode;
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child:  Text(AppLocale.cancel.getString(context)),
  //             onPressed: () {
  //               Navigator.of(dialogContext).pop();
  //             },
  //           ),
  //           TextButton(
  //             child:  Text(AppLocale.update.getString(context)),
  //             onPressed: () async {
  //
  //               isLogin();
  //
  //
  //               // FirebaseFirestore.instance.collection('Owner').doc(FirebaseAuth.instance.currentUser!.uid).update({
  //               //   'phone': Ccode! + phoneController.text,
  //               //   'verified': false
  //               // }).then((value) {
  //               //   Utils.toastMessage('Phone number Updated');
  //               // }).onError((error, stackTrace) {
  //               //   Utils.toastMessage(error.toString());
  //               // });
  //               Navigator.of(dialogContext).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
  //
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // void isLogin() {
  //   final loadingProvider =
  //   Provider.of<LoadingProvider>(context, listen: false);
  //   loadingProvider.loginLoading(true);
  //   _auth
  //       .verifyPhoneNumber(
  //       phoneNumber: Ccode + phoneController.text,
  //       verificationCompleted: (_) {
  //
  //       },
  //       verificationFailed: (e) {
  //         Utils.toastMessage(e.toString());
  //         if (kDebugMode) {
  //           print(e.toString());
  //         }
  //         loadingProvider.loginLoading(false);
  //       },
  //       codeSent: (String verification, int? token) {
  //         if (kDebugMode) {
  //           print(phoneController);
  //         }
  //         // FirebaseFirestore.instance.collection('Owner').doc(FirebaseAuth.instance.currentUser!.uid).update({
  //         //   'phone': Ccode + phoneController.text
  //         // }).then((value) {
  //         //   loadingProvider.loginLoading(false);
  //         //
  //         //   Navigator.push(
  //         //       context,
  //         //       MaterialPageRoute(
  //         //           builder: (context) => OTPVerification(
  //         //             from: 'phone',
  //         //             verificationId: verification,
  //         //             phoneNumber: Ccode+phoneController.text,
  //         //           )));
  //         // }).onError((error, stackTrace) {
  //         //   Utils.toastMessage(error.toString());
  //         // });
  //         loadingProvider.loginLoading(false);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     OTPVerification(
  //                       from: 'phone',
  //                       verificationId: verification,
  //                       phoneNumber: Ccode + phoneController.text,
  //                     )));
  //         if (kDebugMode) {
  //           print(phoneController);
  //         }
  //       },
  //       codeAutoRetrievalTimeout: (e) {
  //         loadingProvider.loginLoading(false);
  //
  //         if (kDebugMode) {
  //           print(e.toString());
  //         }
  //       })
  //       .onError((error, stackTrace) {
  //     Utils.toastMessage(error.toString());
  //     loadingProvider.loginLoading(false);
  //   });
  // }

}

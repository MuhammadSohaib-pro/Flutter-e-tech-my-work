import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_app_bar.dart';
import 'package:elabd_tms_app/components/custom_button.dart';
import 'package:elabd_tms_app/components/custom_text.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:elabd_tms_app/main.dart';
import 'package:elabd_tms_app/models/select_index_controller.dart';
import 'package:elabd_tms_app/screens/profile/reset_password.dart';
import 'package:elabd_tms_app/screens/profile/web_view_screen.dart';
import 'package:elabd_tms_app/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/shared_preferences_model.dart';
import '../login/login_screen.dart';
import 'bank_account_info.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

launchURL() async {
  final Uri url = Uri.parse('https://elabdisb.com/privacy-policy.html');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

User? user = FirebaseAuth.instance.currentUser;
Map<String, dynamic>? userData;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: "Profile",
        backgroundColor: Colors.white,
        textColor: black,
        leading: SizedBox(
          height: 0,
          width: 0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0).r,
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
                              height: 20,
                            ),
                            CustomText(
                              text: userData!['name'],
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomText(
                              text: userData!['email'],
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20.sp,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BankAccountInfo()));
                    },
                    title: 'Bank Account'),
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
                              builder: (context) => ResetPassword()));
                    },
                    title: 'Reset Password'),
                const SizedBox(
                  height: 30,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CustomButton(
                //         width: 90.w,
                //         height: 39.h,
                //         textColor: redColor,
                //         text: "Logout",
                //         color: const Color.fromRGBO(226, 20, 20, 0.18),
                //         onPressed: () {
                //           dialogShow(context);
                //         }),
                //   ],
                // )
                logoutBtn(
                  onTap: () {
                    dialogShow(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
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
                  color: black.withOpacity(0.10))
            ]),
        child: Center(
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
          height: 50,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(2, 2),
                    color: black.withOpacity(0.10))
              ]),
          child: Center(
            child: ListTile(
              onTap: onTap as void Function()?,
              leading: CustomText(
                text: title!,
                fontSize: 14,
                color: black,
                fontWeight: FontWeight.w500,
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

  void dialogShow(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Consumer<AuthServiceProvider>(
                builder: (context, provider, _) => SizedBox(
                  height: 180.h,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Confirm",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0).r,
                          child: CustomText(
                            text: "Are You sure You want to Logout!!",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            TextButton(
                                onPressed: () {
                                  // selectIndexCtrl.selectedIndex.value

                                  getIt<SelectIndexController>().changeIndex(0);

                                  provider.signOut().then((value) {
                                    if (value) {
                                      Navigator.pop(context);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const LoginScreen();
                                      }));
                                      getIt<SelectIndexController>()
                                          .selectedIndex
                                          .value = 0;
                                      getIt<SharedPreferencesModel>()
                                          .setLoginStatus(false);
                                    }
                                  });
                                },
                                child: const Text('Yes')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}

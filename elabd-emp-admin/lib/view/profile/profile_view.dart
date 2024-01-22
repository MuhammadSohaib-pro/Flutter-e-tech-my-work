import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/view/auth/login_view/login_view.dart';
import 'package:elabd_ems_admin/view/manage_task_view/components/button_comp.dart';
import 'package:elabd_ems_admin/view/profile/web_view_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../reset_password/reset_password.dart';
import 'edit_profile.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

launchURL() async {
  final Uri url = Uri.parse('https://elabdisb.com/privacy-policy.html');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

User? user = FirebaseAuth.instance.currentUser;
Map<String, dynamic>? userData;

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(
        title: "Profile",
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
                      return const CircularProgressIndicator();
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
              Center(
                child: SizedBox(
                  width: MySize.screenWidth * 0.3,
                  child: ButtonComp(
                    title: 'LogOut',
                    backColor: redColor.withOpacity(0.50),
                    onTap: () {
                      logOutDialog(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }

  Widget tileWidget({String? title, Function? onTap}) {
    return Column(
      children: [
        Container(
          height: 50,
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

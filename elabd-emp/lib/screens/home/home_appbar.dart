import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/components/custom_text.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:elabd_tms_app/screens/home/notification_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../chat/chat_users_list.dart';
import '../../models/user_model.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  int unreadCount = 0;
  Future<void> fetchUnreadNotificationCount() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('notifications').where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
      int count =
          querySnapshot.docs.where((doc) => doc['isRead'] == false).length;
      setState(() {
        unreadCount = count; // Update the unread count
        print('count value is $unreadCount');
      });
    } catch (error) {
      print('Error fetching unread count: $error');
    }
  }

  @override
  void initState() {
    fetchUnreadNotificationCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todayDate = DateTime.now();
    final formattedDate = DateFormat('MMM dd, y').format(todayDate);
    return SizedBox(
      // color: primaryColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    // 'May 12,2023',
                    text: formattedDate.toString(),
                    fontSize: 14, fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // it's may be null
                          // no need of this this is when we check from splash screen etc
                          User? user = FirebaseAuth.instance.currentUser;
                          debugPrint(user.toString());
                          DocumentSnapshot userData = await FirebaseFirestore
                              .instance
                              .collection('employees')
                              .doc(user!.uid)
                              .get();
                          debugPrint('The User is $user');
                          // UserModel userModel = UserModel.fromJson(
                          //     userData.data() as Map<String, dynamic>);
                          UserModel userModel = UserModel.fromJson(
                              userData.data() as Map<String, dynamic>);
                          String name = userModel.name ?? '';
                          String email = userModel.email ?? '';
                          debugPrint(" my name is $name");
                          debugPrint(" the email is $email");

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatUsersList(
                                        userData: userModel,
                                      )));
                        },
                        child: Image.asset(
                          'assets/images/chat.png',
                          height: 24,
                          width: 22,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, notification);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationView()));
                        },
                        child: SizedBox(
                          height: 24,
                          width: 22,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                'assets/images/notification.png',
                                height: 24,
                                width: 22,
                              ),
                              Positioned(
                                right: -2,
                                top: -3,
                                child: Container(
                                  height: 12,
                                  width: 12,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: Center(
                                      child: CustomText(
                                    // '11',
                                    text: unreadCount.toString(),

                                    color: Colors.white,
                                    fontSize: 8,
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const CustomText(
                text: 'Today',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ]),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/routes/routes_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../../../chat/chat_users_list.dart';
import '../../../model/user_model.dart';

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
          await FirebaseFirestore.instance.collection('notifications').get();
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
    MySize().init(context);
    final todayDate = DateTime.now();
    final formattedDate = DateFormat('MMM dd, y').format(todayDate);
    return SizedBox(
      // color: primaryColor,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MySize.size20, vertical: MySize.size8),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // 'May 12,2023',
                    formattedDate.toString(),
                    style: poppinLight.copyWith(color: lightGrey),
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
                          AppIcons.chat,
                          height: MySize.size24,
                          width: MySize.size22,
                        ),
                      ),
                      SizedBox(
                        width: MySize.size12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, notification);
                        },
                        child: SizedBox(
                          height: MySize.size24,
                          width: MySize.size22,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Image.asset(
                                AppIcons.notification,
                                height: MySize.size24,
                                width: MySize.size22,
                              ),
                              Positioned(
                                right: -2,
                                top: -3,
                                child: Container(
                                  height: MySize.size12,
                                  width: MySize.size12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: Center(
                                      child: Text(
                                    // '11',
                                    unreadCount.toString(),
                                    style: poppinLight.copyWith(
                                        color: whiteColor,
                                        fontSize: MySize.size8),
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
              Text(
                'Today',
                style: poppinSemiBold.copyWith(fontSize: MySize.size16),
              ),
            ]),
      ),
    );
  }
}

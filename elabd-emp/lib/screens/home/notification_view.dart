// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_tms_app/constants/colors.dart';
import 'package:elabd_tms_app/models/notification_model.dart';
import 'package:elabd_tms_app/screens/home/components/notification_card.dart';
import 'package:elabd_tms_app/screens/home/leave_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Future<List<NotificationModel>> fetchNotifications() async {
    List<NotificationModel> notifications = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    notifications = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return NotificationModel.fromJson(data);
    }).toList();
    return notifications;
  }

  Future<void> markAllNotificationsAsRead() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('notifications').get();

      List<Future<void>> updateTasks = [];

      // ignore: avoid_function_literals_in_foreach_calls
      querySnapshot.docs.forEach((doc) {
        updateTasks.add(
          doc.reference.update({'isRead': true}),
        );
      });

      await Future.wait(updateTasks);
      setState(() {});

      debugPrint('All notifications marked as read successfully');
    } catch (error) {
      debugPrint('Error marking notifications as read: $error');
    }
  }

  Future<void> markNotificationAsRead(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(documentId)
          .update({'isRead': true});
      debugPrint('Notification marked as read successfully');
    } catch (error) {
      debugPrint('Error marking notification as read: $error');
    }
  }

  @override
  void initState() {
    fetchNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Poppins',
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () async {
                  await markAllNotificationsAsRead();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Mark as Read',
                    style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Poppins',
                        color: primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: FutureBuilder<List<NotificationModel>>(
                future: fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<NotificationModel> notifications = snapshot.data!;

                    // Display notifications using ListView.builder or any other widget
                    return ListView.separated(
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 14,
                      ),
                      shrinkWrap: true,
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        NotificationModel notification = notifications[index];
                        return GestureDetector(
                          onTap: () async {
                            await markNotificationAsRead(notification.userId!);
                            if (notification.notificationType ==
                                "leaveRequest") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LeaveRequests()));
                            }

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => LeaveRequest(notifications: notifications,)));
                          },
                          child: NotificationCard(
                            // You need to pass the actual properties to the NotificationCard widget
                            personName: notification.name!,
                            notificationDesc: notification.title!,
                            personImage: notification.image!,
                            isRead: notification.isRead!,
                            // Other properties...
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text('No notifications found.');
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

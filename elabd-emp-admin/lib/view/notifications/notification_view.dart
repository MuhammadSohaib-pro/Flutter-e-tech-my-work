// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_ems_admin/helper/import_helper.dart';
import 'package:elabd_ems_admin/model/notification_model.dart';
import 'package:elabd_ems_admin/view/notifications/leave_request.dart';

import 'components/notification_card.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  Future<List<NotificationModel>> fetchNotifications() async {
    List<NotificationModel> notifications = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('notifications').get();

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
    MySize().init(context);
    return Scaffold(
      appBar: const AppBarWidget(title: 'Notifications'),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MySize.size14),
        child: Column(
          children: [
            SizedBox(
              height: MySize.size10,
            ),
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () async {
                  await markAllNotificationsAsRead();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Mark as Read',
                    style: poppineRegular.copyWith(
                        fontSize: MySize.size10, color: primaryColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MySize.size8,
            ),
            Expanded(
              child: FutureBuilder<List<NotificationModel>>(
                future: fetchNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Loading indicator
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
                            if (notification.notificationType=="leaveRequest") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LeaveRequest()));
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

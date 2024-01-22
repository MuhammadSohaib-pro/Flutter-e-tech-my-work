import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wheremyelabd/Utils/textstyle.dart';

class NotificationComponent extends StatefulWidget {
  final String title;
  final IconData icon;
  final String subtitle;

  const NotificationComponent({
    required this.title,
    required this.icon,
    required this.subtitle,

    Key? key,
  }) : super(key: key);

  @override
  _NotificationComponentState createState() => _NotificationComponentState();
}

class _NotificationComponentState extends State<NotificationComponent> {
  bool notificationEnabled = false;

  @override
  void initState() {
    super.initState();
    // Load the notification state when the widget initializes
    loadNotificationState();
  }

  void loadNotificationState() async {
    // Check if the user is signed in with Google
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Get the user's document from Firestore
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      final userData = await userDoc.get();
      if (userData.exists) {
        final notificationData = userData.get('notification') ?? false;
        setState(() {
          notificationEnabled = notificationData;
        });
      }
    }
  }

  void updateNotificationState(bool enabled) async {
    // Check if the user is signed in with Google
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Update the user's document in Firestore with the new notification state
      final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
      await userDoc.set({'notification': enabled}, SetOptions(merge: true));
      setState(() {
        notificationEnabled = enabled;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle the notification state and update it in Firebase
        updateNotificationState(!notificationEnabled);
      },
      child: Container(
        width: 363,
        height: 71,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[ Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      color: Colors.blue,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                widget.subtitle,
                                style: MyTextStyles.settingsGrey(11.0)
                            ),
                            Text(
                              widget.title,
                              style: MyTextStyles.settingsblacklit,
                            ),
                          ],
                        ),


                  ],
                ),

                  Row(
                 //   mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    IconButton(
                      onPressed: () {
                        // Toggle the notification state and update it in Firebase
                        updateNotificationState(!notificationEnabled);
                      },
                      icon: Icon(
                        notificationEnabled ? Icons.toggle_on : Icons.toggle_off,
                        color: notificationEnabled ? Colors.green : Colors.red,
                        size: 40,
                      ),
                    ),
                  ],),
        ],
              ),


            ),
            const SizedBox(height: 2,),
            Container(
              width: 365,
              height: 1,
              decoration: const BoxDecoration(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

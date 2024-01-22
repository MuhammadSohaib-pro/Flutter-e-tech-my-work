import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../services/notification_services.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  const MessageTextField(this.currentId, this.friendId, {super.key});

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final TextEditingController _controller = TextEditingController();
  NotificationServices notificationServices = NotificationServices();

  // Future<void> sendNotification(String message, String recipientId) async {
  //   notificationServices.getDeviceToken().then((value) async{
  //     var data = {
  //       'to': value.toString(),
  //       'priority': 'high',
  //       'notification': {'title': 'New Message', 'body': message,
  //       }
  //     };
  //     final response = await http.post(
  //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //     body: jsonEncode(data),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization':
  //           'key=AAAAO3inPrY:APA91bFCzWSlLgHavPKWYx5xvrGlmsr2rLnLjXP9bfoEV9eoW46p9brN6-AFbfQNhgoSCU_WmGnhm9G8QtAAjqIPVozXEYhGUiwB2VPlo7ORpxJJt-tpgAp1_MGCb_EYYmeHzSaMKX49', // Replace with your FCM server key
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     print('Notification sent successfully');
  //   } else {
  //     print('Error sending notification: ${response.body}');
  //   }
  //   },
  //   );
  // }

  Future<void> sendNotification(String message, String recipientId) async {
    final deviceTokenSnapshot = await FirebaseFirestore.instance
        .collection('employees')
        .doc(recipientId)
        .get();

    final deviceToken = deviceTokenSnapshot.data()?['fcmToken'];

    if (deviceToken != null) {
      final data = {
        'to': deviceToken,
        'priority': 'high',
        'notification': {
          'title': deviceTokenSnapshot.data()?['name'],
          'body': message
        }
      };

      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAAl8yn4mw:APA91bEZK68EvntCRTTTS7DT7YNb8KiKnVoDjPqRQ_2arUus-MY00PdSDkppe9iakGui2NJiPIW74N8EqN16kjiR9bxJmKTP4zWovCdkt7UJ2dAj8z2qFuuN_anYhHECVh4kVhspBXj9'
        },
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print('Error sending notification: ${response.body}');
      }
    } else {
      print('Recipient device token not found');
    }
  }

  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print('Device Token is');
      print(value);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
                labelText: "Type your Message",
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25))),
          )),
          const SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () async {
              String message = _controller.text;
              _controller.clear();
              await sendNotification(message, widget.friendId);
              await FirebaseFirestore.instance
                  .collection('employees')
                  .doc(widget.currentId)
                  .collection('messages')
                  .doc(widget.friendId)
                  .collection('chats')
                  .add({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection('employees')
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .set({
                  'last_msg': message,
                });
              });

              await FirebaseFirestore.instance
                  .collection('employees')
                  .doc(widget.friendId)
                  .collection('messages')
                  .doc(widget.currentId)
                  .collection("chats")
                  .add({
                "senderId": widget.currentId,
                "receiverId": widget.friendId,
                "message": message,
                "type": "text",
                "date": DateTime.now(),
              }).then((value) {
                FirebaseFirestore.instance
                    .collection('employees')
                    .doc(widget.friendId)
                    .collection('messages')
                    .doc(widget.currentId)
                    .set({"last_msg": message});
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}

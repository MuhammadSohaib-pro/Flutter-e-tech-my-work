
import 'dart:convert';
import 'package:boat_app/notifications/push_notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class NotificationServices with ChangeNotifier{
  //FirebaseMessaging messaging = FirebaseMessaging.instance;

  late final FirebaseMessaging _messaging;
  PushNotification? _notificationInfo;
  String? token;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  void requestAndRegisterNotification()async{
    //1. Intilize the firebase app
    await Firebase.initializeApp();

    //2.intantiate firebase messaging
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(FirebaseMessagingBackgroundHandler);

    // 3.Take user permission on ios
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true
    );

    if(settings.authorizationStatus ==AuthorizationStatus.authorized)
    {
      print("user permission granted");
      token = await _messaging.getToken();
      print("the token is "+token!);
      //for handling the received notification
      FirebaseMessaging.onMessage.listen((RemoteMessage message){
        //parse the message received
        print(message.notification?.title);
        print(message.notification?.body);

        NotificationDetails platformChannelSpecfics = NotificationDetails(iOS: const IOSNotificationDetails());

        flutterLocalNotificationsPlugin.show(0, message.notification!.title,
            message.notification!.body, platformChannelSpecfics,payload: message.data['body']);

        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );
          _notificationInfo = notification;
        if(_notificationInfo != null)
        {
          showSimpleNotification(Text(_notificationInfo!.title!),subtitle: Text(_notificationInfo!.body!),
              background: Colors.cyan.shade700,
              duration: Duration(seconds: 10));
        }
      });
    }
    initInfo();
  }

  Future<void> sendToken(String uid)
  async {
    await FirebaseFirestore.instance.collection('User').doc(uid).update({
      "token" : token
    });
  }

  void sendPushMessage(String tokenReceiver,String body,String title) async{

    try{
      await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: <String,String>{
        "Content-Type" : "application/json",
        "Authorization" : "key=AAAAg34FTko:APA91bGvcB7_tkJm5KD4tfv2GWUDBs3xEru20qjb5ChZpIrGjqTeTnvh5kaWHlH04mpN4ie6ClpK3V76kfwC_iRGPhnY8RZrxCUqJBQJS5eQmocQ6fX8juKLNI8DxZ19xvh5H2b3zmMK"
      },body:  jsonEncode(<String,dynamic> {

        'priority': 'high',
            'data' :<String, dynamic>{
                 'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
                  'status' : 'done',
              'body' : body,
              'title': title
            },
            "notification" : <String,dynamic>{
             "title" :title,
              "body" : body,
              "android_channel_id" : "boat"
            },
            "to" : tokenReceiver
          })
      );
    }catch(e){
      if(kDebugMode){
        print("error push notification");
    }
    }
  }

  initInfo() {
    // var androidInitialize = const AndroidInitializationSettings(
    //   '@mipmap/ic_launcher');
    var IOSInitialize = const IOSInitializationSettings();


    InitializationSettings initializationSettings = InitializationSettings(
      //android: androidInitialize,
        iOS: IOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (String? payload) async
    {
      try {
        if (payload != null && payload.isNotEmpty) {

        } else {

        }
      }
      catch(e){}

    });
  }


}
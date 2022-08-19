import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_delivery_owner/src/controllers/notification_controller.dart';

class PushNotificationService {
  static PushNotificationService? _instance;

  PushNotificationService._();

  static PushNotificationService get instance => _instance ??= PushNotificationService._();


  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    
    
    if (Platform.isIOS) {
      await Future.delayed(const Duration(seconds: 2));
        await _fcm.requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
    }
    try{
      FirebaseMessaging.onMessage.listen(
      
        (RemoteMessage message) {
          print("lissenning");
          print(message);

           _handleForgroundMessages(message);

        }
    );
   
      FirebaseMessaging.onMessageOpenedApp.listen(
        (RemoteMessage message) => print("_handleBackgroundMessages(message)"),
      );

      await _handleTerminatedBackgroundMessages();
     

    }catch (e) {
      print('notification service initialise error => $e');
    }

  }
  Future<String?> getDeviceToken() async {
    final token = await _fcm.getToken();
    print('FCM Token => $token');
    return token;
  }


  Future<void> _handleForgroundMessages(RemoteMessage message) async {
    print('handleForgroundMessages');
    if (message.notification?.title != null &&
        message.notification?.body != null) {
          _showNotificationCustomSound(message.notification?.title.toString()??"",message.notification?.body??"");
     print("noooootification:::::");
    }
   // _updateAccountRefuseStateFromMessage(message);
  }
    Future<void> _handleTerminatedBackgroundMessages() async {
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      _showNotificationCustomSound("title","body");
      print('handleTerminatedBackgroundMessages');
     // _updateAccountRefuseStateFromMessage(initialMessage);
    }
  }
  
   Future<void> _showNotificationCustomSound(String title,String body) async {
     const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            sound: RawResourceAndroidNotificationSound('suaramessengernotification'));
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics
        );
  
    const IOSNotificationDetails iOSPlatformChannelSpecifics =
        IOSNotificationDetails(sound: 'suaramessengernotification.aiff');
    const MacOSNotificationDetails macOSPlatformChannelSpecifics =
        MacOSNotificationDetails(sound: 'suaramessengernotification.aiff');
    final LinuxNotificationDetails linuxPlatformChannelSpecifics =
        LinuxNotificationDetails(
      sound: AssetsLinuxSound('sound/suaramessengernotification.mp3'),
    );
   
  }
}
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_delivery_owner/src/repository/firebase_notification.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../helpers/custom_trace.dart';
import '../repository/settings_repository.dart' as settingRepo;
import '../repository/user_repository.dart' as userRepo;

class SplashScreenController extends ControllerMVC with ChangeNotifier {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState>? scaffoldKey;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  Future<void> initState() async {
    super.initState();
    Firebase.initializeApp();
        
    firebaseMessaging.requestPermission(sound: true, badge: true, alert: true);
    // firebaseMessaging.requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    configureFirebase(firebaseMessaging);
   // _requestPermissions();
    settingRepo.setting.addListener(() {
      if (settingRepo.setting.value.appName != null && settingRepo.setting.value.appName != '' && settingRepo.setting.value.mainColor != null) {
        progress.value["Setting"] = 41;
        progress.notifyListeners();
      }
    });
    userRepo.currentUser.addListener(() {
      if (userRepo.currentUser.value.auth != null) {
        progress.value["User"] = 59;
        progress.notifyListeners();
      }
    });
     await PushNotificationService.instance.initialize();
    String? fcmToken = await  PushNotificationService.instance.getDeviceToken();
    
    Timer(Duration(seconds: 20), () {
      ScaffoldMessenger.of(state!.context).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).verify_your_internet_connection),
      ));
    });

    
  }
  // Future onSelectNotification(String payload) async {
  //   showDialog(
  //     context: state!.context,
  //     builder: (_) {
  //       return new AlertDialog(
  //         title: Text("PayLoad"),
  //         content: Text("Payload : $payload"),
  //       );
  //     },
  //   );
  // }
  // void showNotification(String title, String body) async {
  //   await _demoNotification(title, body);
  // }
  // void _requestPermissions() {
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       IOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //       MacOSFlutterLocalNotificationsPlugin>()
  //       ?.requestPermissions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );
  // }
  // Future<void> _demoNotification(String title, String body) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'channel_ID', 'channel name', 'channel description',
  //       importance: Importance.max,
  //       playSound: true,
  //       sound: RawResourceAndroidNotificationSound('swiftly'),
  //       showProgress: true,
  //       priority: Priority.high,
  //       ticker: 'test ticker');
  //
  //   var iOSChannelSpecifics = IOSNotificationDetails();
  //   var platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
  //   await flutterLocalNotificationsPlugin
  //       .show(0, title, body, platformChannelSpecifics, payload: 'test');
  // }
  void configureFirebase(FirebaseMessaging _firebaseMessaging) {
    try {
         FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   print('Got a message whilst in the foreground!');
      //   print('Message data: ${message.data}');

      if (message.notification != null) {
        // print('Message also contained a notification: ${message.notification}');
        
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
      print(CustomTrace(StackTrace.current, message: 'Error Config Firebase'));
    }
  }

  Future notificationOnResume(Map<String, dynamic> message) async {
    print(CustomTrace(StackTrace.current, message: message['data']['id']));
    try {
      if (message['data']['id'] == "orders") {
        settingRepo.navigatorKey.currentState!.pushReplacementNamed('/Pages', arguments: 2);
      } else if (message['data']['id'] == "messages") {
        settingRepo.navigatorKey.currentState!.pushReplacementNamed('/Pages', arguments: 3);
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Future notificationOnLaunch(Map<String, dynamic> message) async {
    String messageId = await settingRepo.getMessageId();
    try {
      if (messageId != message['google.message_id']) {
        await settingRepo.saveMessageId(message['google.message_id']);
        if (message['data']['id'] == "orders") {
          settingRepo.navigatorKey.currentState!.pushReplacementNamed('/Pages', arguments: 2);
        } else if (message['data']['id'] == "messages") {
          settingRepo.navigatorKey.currentState!.pushReplacementNamed('/Pages', arguments: 3);
        }
      }
    } catch (e) {
      print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Future notificationOnMessage(Map<String, dynamic> message) async {
    //_demoNotification(message['notification']['title'],message['notification']['body']);
    Fluttertoast.showToast(
      msg: message['notification']['title'],
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 6,
    );
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../models/notification.dart' as model;
import '../repository/notification_repository.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class NotificationController extends ControllerMVC {
  List<model.Notification> notifications = <model.Notification>[];
  int unReadNotificationsCount = 0;
  GlobalKey<ScaffoldState>? scaffoldKey;

  NotificationController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    listenForNotifications();
  }

  void listenForNotifications({String? message}) async {
    final Stream<model.Notification> stream = await getNotifications_1();
    stream.listen((model.Notification _notification) {
      setState(() {
        notifications.add(_notification);
      });
    }, onError: (a) {
      print("error");
      print(a);
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).verify_your_internet_connection),
      ));
    }, onDone: () {
      if (notifications.isNotEmpty) {
        unReadNotificationsCount = notifications.where((model.Notification _n) => !_n.read!).toList().length;
      } else {
        unReadNotificationsCount = 0;
      }
      if (message != null) {
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> refreshNotifications() async {
    notifications.clear();
    listenForNotifications(message: S.of(state!.context).notifications_refreshed_successfuly);
  }

  void doMarkAsReadNotifications(model.Notification _notification) async {
    markAsReadNotifications(_notification).then((value) {
      setState(() {
        --unReadNotificationsCount;
        _notification.read = !_notification.read!;
      });
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).thisNotificationHasMarkedAsRead),
      ));
    });
  }

  void doMarkAsUnReadNotifications(model.Notification _notification) {
    markAsReadNotifications(_notification).then((value) {
      setState(() {
        ++unReadNotificationsCount;
        _notification.read = !_notification.read!;
      });
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).thisNotificationHasMarkedAsUnRead),
      ));
    });
  }

  void doRemoveNotification(model.Notification _notification) async {
    removeNotification(_notification).then((value) {
      setState(() {
        if (!_notification.read!) {
          --unReadNotificationsCount;
        }
        this.notifications.remove(_notification);
      });
      ScaffoldMessenger.of(scaffoldKey!.currentContext!).showSnackBar(SnackBar(
        content: Text(S.of(state!.context).notificationWasRemoved),
      ));
    });
  }
//  Future<void> _showNotificationCustomSound() async {
//      const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             channelDescription: 'your channel description',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker',
//             sound: RawResourceAndroidNotificationSound('kalho'));
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics
//         );
  
//     const IOSNotificationDetails iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(sound: 'slow_spring_board.aiff');
//     const MacOSNotificationDetails macOSPlatformChannelSpecifics =
//         MacOSNotificationDetails(sound: 'slow_spring_board.aiff');
//     final LinuxNotificationDetails linuxPlatformChannelSpecifics =
//         LinuxNotificationDetails(
//       sound: AssetsLinuxSound('sound/slow_spring_board.mp3'),
//     );
//     // final NotificationDetails platformChannelSpecifics = NotificationDetails(
//     //   android: androidPlatformChannelSpecifics,
//     //   iOS: iOSPlatformChannelSpecifics,
//     //   macOS: macOSPlatformChannelSpecifics,
//     //   linux: linuxPlatformChannelSpecifics,
//     // );
//     // await flutterLocalNotificationsPlugin.show(
//     //   0,
//     //   'custom sound notification title',
//     //   'custom sound notification body',
//     //   platformChannelSpecifics,
//     // );
//   }

 }

// import 'package:firebase_messaging/firebase_messaging.dart';

// class NotificationServices {
//   FirebaseMessaging messsaging = FirebaseMessaging.instance;

//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messsaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       print('User granted permission');
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       print('User granted provisional permission');
//     } else {
//       print('User declined or has not accepted permission');
//     }
//   }
// }

import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final notification = FlutterLocalNotificationsPlugin();
  static initialise() async {
    AndroidInitializationSettings android =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iOS = DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    notification.initialize(initializationSettings);
    if (Platform.isAndroid) {
      await notification
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();
    } else {
      await notification
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions();
    }
  }

  static show(RemoteMessage message) async {
    AndroidNotificationDetails android =
        AndroidNotificationDetails("channelId", "channelName");
    DarwinNotificationDetails iOS = DarwinNotificationDetails();

    NotificationDetails details = NotificationDetails(
      android: android,
      iOS: iOS,
    );

    await notification.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      details,
    );
  }
}

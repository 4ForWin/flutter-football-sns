// notification_service.dart

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void initLocalNotification() {
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);
  flutterLocalNotificationsPlugin.initialize(initSettings);
}

void showNotification(RemoteMessage message) {
  const androidDetails = AndroidNotificationDetails(
    'important_channel',
    '중요 알림',
    importance: Importance.max,
    priority: Priority.high,
  );
  const notificationDetails = NotificationDetails(android: androidDetails);

  flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title,
    message.notification?.body,
    notificationDetails,
  );
}

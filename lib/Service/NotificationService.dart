import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationService extends ChangeNotifier {
  static final NotificationService _notificationService =
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channel_id = "123";

  Future<void> init() async {
   // print("initialize");
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings iosInitializationSettings = IOSInitializationSettings();

    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid, iOS: iosInitializationSettings, macOS: null);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings)
    .then((value) => print("Init Notification Log:" + value.toString()));
  }

  // void cancelAllNotifications() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }
  //
  // Future instantNofitication() async {
  //   var android = AndroidNotificationDetails("id", "channel", "description");
  //
  //   var ios = IOSNotificationDetails();
  //
  //   var platform = new NotificationDetails(android: android, iOS: ios);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //       0, "Demo instant notification", "Tap to do something", platform,
  //       payload: "Welcome to demo app");
  // }

  // final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  //
  // //initilize
  //
  // Future initialize() async {
  //   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //   FlutterLocalNotificationsPlugin();
  //
  //   AndroidInitializationSettings androidInitializationSettings =
  //   AndroidInitializationSettings("@mipmap/ic_launcher");
  //
  //   IOSInitializationSettings iosInitializationSettings =
  //   IOSInitializationSettings();
  //
  //   final InitializationSettings initializationSettings =
  //   InitializationSettings(
  //       android: androidInitializationSettings,
  //       iOS: iosInitializationSettings);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  //Instant Notifications
  Future instantNofitication() async {
    var android = AndroidNotificationDetails("id", "channel", "description");

    var ios = IOSNotificationDetails();

    var platform = new NotificationDetails(android: android, iOS: ios);

    await flutterLocalNotificationsPlugin.show(
        0, "Demo instant notification", "Tap to do something", platform,
        payload: "Welcome to demo app");
  }

}
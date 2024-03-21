import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Noti {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Noti() {
    init_noti();
  }

  void init_noti() async {
    WidgetsFlutterBinding.ensureInitialized();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestExactAlarmsPermission();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> show_noti() async {
    const String channelId = '001';
    const String channelName = 'Testtttt';
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: channelName,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin
        .show(1, "title", "body", platformChannelSpecifics, payload: 'item x');
  }

  Future<void> show_noti2() async {
    const String channelId = '001';
    const String channelName = 'Testtttt';
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: channelName,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(android: androidNotificationDetails);

    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = now.add(const Duration(seconds: 10));
    await flutterLocalNotificationsPlugin.zonedSchedule(0, 'scheduled title',
        'scheduled body', scheduledDate, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: 'item x');
  }

  Future<void> ScheduleNoti(int hour,int minute) async {
    const String channelId = '001';
    const String channelName = 'Testtttt';
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: channelName,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');

    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(android: androidNotificationDetails);

    tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var scheduleTime = DateTime(now.year, now.month, now.day, hour,
        minute);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        Random().nextInt(10000),
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.from(scheduleTime, tz.local),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: scheduleTime.toString());
  }

Future<void> ScheduleNotiSec(int sec) async {
  const String channelId = '001';
  const String channelName = 'Testtttt';
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(channelId, channelName,
          channelDescription: channelName,
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');

  NotificationDetails platformChannelSpecifics =
      const NotificationDetails(android: androidNotificationDetails);

  tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduleTime;

  // Check if the specified minute is in the future. If not, schedule for the next hour.
  // if (now.minute < minute) {
    scheduleTime = tz.TZDateTime(tz.local, now.year, now.month, now.day, now.hour, now.minute, now.second + sec);
  // } else {
  //   // Note: Adding one hour to the current time.
  //   tz.TZDateTime nextHour = now.add(Duration(hours: 1));
  //   scheduleTime = tz.TZDateTime(tz.local, nextHour.year, nextHour.month, nextHour.day, nextHour.hour, minute);
  // }

  await flutterLocalNotificationsPlugin.zonedSchedule(
      Random().nextInt(10000),
      'scheduled title',
      'scheduled body',
      scheduleTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: scheduleTime.toString());
}


  Future<void> ListAll() async {
    final List<PendingNotificationRequest> pendingNoti =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();

    for (var noti in pendingNoti) {
      print(noti.id);
      print(noti.title);
      print(noti.body);
      print(noti.payload);
    }
    print(pendingNoti.length);
  }

  Future<void> CancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

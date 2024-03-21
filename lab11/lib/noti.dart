import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Noti {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const String channelId = 'channelId_1';
  static const String channelName = 'channelName';

  Noti() {
    noti();
  }

  noti() async {
    WidgetsFlutterBinding.ensureInitialized();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    tz.initializeTimeZones();
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'channelDescription',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Hello World!',
      'This is a notification!',
      platformChannelSpecifics,
    );
  }

  Future<void> showNotification2() async {
    Person admin = const Person(name: 'admin');

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: 'channelDescription',
            importance: Importance.high,
            priority: Priority.defaultPriority,
            ticker: 'ticker',
            styleInformation: MessagingStyleInformation(
              admin,
              conversationTitle: 'conversationTitle',
              groupConversation: true,
              messages: [
                Message('กลับได้เลยครับ', DateTime.now(), null),
              ],
            ));
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Hello World!',
      'This is a notification!',
      platformChannelSpecifics,
    );
  }

  Future<void> showNotification3() async {
    Person admin = const Person(name: 'admin');

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: 'channelDescription',
            importance: Importance.high,
            priority: Priority.defaultPriority,
            ticker: 'ticker',
            styleInformation: MessagingStyleInformation(
              admin,
              conversationTitle: 'conversationTitle',
              groupConversation: true,
              messages: [
                Message('กลับได้เลยครับ', DateTime.now(), null),
              ],
            ));
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        2,
        'Hello World!',
        'This is a notification!',
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future<TimeOfDay> SetingTime(BuildContext context) async {
    tz.TZDateTime mydate = tz.TZDateTime.now(tz.local);
    TimeOfDay seletedTime = TimeOfDay.now();
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: seletedTime,
    );
    print("To Day : ${mydate.day} ${mydate.month} ${mydate.year}");
    print("${picked?.hour} : ${picked?.minute}");
    return picked!;
  }

Future<void> showNotification4(BuildContext context) async {
    TimeOfDay? selectedTime = await settingTime(context);
    if (selectedTime != null) {
      print("Selected time: ${selectedTime.hour}:${selectedTime.minute}");

      // Convert selectedTime to DateTime
      DateTime now = DateTime.now();
      DateTime scheduledTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      // Schedule notification if the selected time is in the future
      if (scheduledTime.isAfter(now)) {
        await scheduleNotificationAt(scheduledTime);
      } else {
        // Handle case when selected time has already passed
        print("Selected time has already passed!");
      }
    }
  }

  Future<TimeOfDay?> settingTime(BuildContext context) async {
    tz.TZDateTime mydate = tz.TZDateTime.now(tz.local);
    TimeOfDay selectedTime = TimeOfDay.now();
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    print("today is ${mydate.day}-${mydate.month}-${mydate.year}");
    print("current time is ${timeOfDay!.hour} ${timeOfDay.minute}");
    return timeOfDay;
  }

  Future<void> scheduleNotificationAt(DateTime scheduledTime) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channelId, channelName,
            channelDescription: "Scheduled_Notification",
            importance: Importance.high,
            priority: Priority.defaultPriority,
            ticker: "ticker");

    NotificationDetails platformAndroid =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      3,
      channelId,
      channelName,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformAndroid,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}

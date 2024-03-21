import 'package:flutter/material.dart';
import 'package:lab11/noti.dart';

class ShowNoti extends StatefulWidget {
  const ShowNoti({super.key});

  @override
  State<ShowNoti> createState() => _ShowNotiState();
}

class _ShowNotiState extends State<ShowNoti> {
  Noti noti = Noti();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show Notification'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                noti.showNotification();
              },
              child: const Text('Show Notification'),
            ),
            ElevatedButton(
              onPressed: () {
                noti.showNotification2();
              },
              child: const Text('Show Notification 2'),
            ),
            ElevatedButton(
                onPressed: () {
                  noti.SetingTime(context);
                },
                child: Text("Seting Time")),
            ElevatedButton(
                onPressed: () {
                  noti.showNotification3();
                },
                child: Text("Show Notification 3")),
            ElevatedButton(
                onPressed: () {
                  noti.showNotification4(context);
                },
                child: Text("Show Notification 4")),
          ],
        ),
      ),
    );
  }
}

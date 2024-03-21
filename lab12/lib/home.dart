import 'package:flutter/material.dart';
import 'package:lab12/noti.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Noti().show_noti();
                },
                child: Text("Text Noti")),
            ElevatedButton(
                onPressed: () {
                  Noti().show_noti2();
                },
                child: Text("Schedule Noti")),
            ElevatedButton(onPressed: (){
              Noti().ListAll();
            }, child: Text("Show All Noti")),
            ElevatedButton(onPressed: (){
              Noti().CancelAll();
            }, child: Text("Cancel Noti")),
            ElevatedButton(onPressed: () async{
              TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
              Noti().ScheduleNoti(time!.hour, time.minute);
            }, child: Text("Set Time"))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lab2/page2.dart';
import 'package:lab2/page3.dart';
import 'package:lab2/page4.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Main Menu",
        ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.deepPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Main Menu",
              style: TextStyle(fontSize: 50, color: Colors.white)),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Page2()));
            },
            icon: const Icon(Icons.access_alarm),
            label: const Text("Go To Page 2"),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Page3()));
            },
            icon: const Icon(Icons.access_alarm),
            label: const Text("Go To Page 3"),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Page4()));
            },
            icon: const Icon(Icons.access_alarm),
            label: const Text("Go To Page 4"),
          )
        ],
      ),
    );
  }
}

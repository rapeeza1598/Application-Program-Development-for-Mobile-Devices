import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
      title: const Text("Page 2"),
      backgroundColor: Colors.orangeAccent,
      foregroundColor: Color.fromARGB(255, 255, 255, 255)
    ),
      backgroundColor: const Color.fromARGB(255, 58, 183, 98),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text("Body Page 2",
              style: TextStyle(fontSize: 50, color: Colors.white)),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50)),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.access_alarm),
            label: const Text("Go To Page 1"),
          ),
          ElevatedButton(onPressed: (){}, child: Text("Go To Page"))
        ],
      ),
    );
  }
}
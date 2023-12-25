import 'package:flutter/material.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  final text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Page 3"),
          backgroundColor: Colors.greenAccent,
          foregroundColor: const Color.fromARGB(255, 255, 255, 255)),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Enter Any Text"),
        TextField(
          controller: text,
          onChanged: (text) {
            setState(() {});
          },
        ),
        ElevatedButton(
            onPressed: () {
              todo();
            },
            child: Text("Process ${text.text}"))
      ]),
    );
  }

  void todo() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("แสดงข้อความ"),
            content: Text("ข้อความ:\n${text.text}"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancal")),
            ],
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          );
        });
  }
}

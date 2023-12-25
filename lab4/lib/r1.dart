import 'package:flutter/material.dart';

class r1 extends StatefulWidget {
  const r1({super.key});

  @override
  State<r1> createState() => _r1State();
}

class _r1State extends State<r1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.lightbulb,
            color: Colors.yellowAccent,
          ),
          title: const Text("Quiz"),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(children: [
                    const Text(
                      "โจทย์",
                      style: TextStyle(fontSize: 32),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: const [
                        ListTile(
                          title: Text("ตัวเลือกที่ 1"),
                        ),
                        ListTile(
                          title: Text("ตัวเลือกที่ 2"),
                        ),
                        ListTile(
                          title: Text("ตัวเลือกที่ 3"),
                        ),
                        ListTile(
                          title: Text("ตัวเลือกที่ 4"),
                        ),
                      ],
                    )
                  ]),
                ]),
          ),
        ));
  }
}

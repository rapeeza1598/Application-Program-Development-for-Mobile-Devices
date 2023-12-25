import 'package:flutter/material.dart';

class r1 extends StatefulWidget {
  const r1({super.key});

  @override
  State<r1> createState() => _r1State();
}

class _r1State extends State<r1> {
  late int selChoice = 0;
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
                      children: [
                        ListTile(
                          leading: Radio(
                              value: 1,
                              groupValue: selChoice,
                              onChanged: (int? value) {
                                setState(() {
                                  selChoice = value!;
                                });
                              }),
                          title: Text("ตัวเลือกที่ 1"),
                        ),
                        ListTile(
                          leading: Radio(
                              value: 2,
                              groupValue: selChoice,
                              onChanged: (int? value) {
                                setState(() {
                                  selChoice = value!;
                                });
                              }),
                          title: Text("ตัวเลือกที่ 2"),
                        ),
                        ListTile(
                          leading: Radio(
                              value: 3,
                              groupValue: selChoice,
                              onChanged: (int? value) {
                                setState(() {
                                  selChoice = value!;
                                });
                              }),
                          title: Text("ตัวเลือกที่ 3"),
                        ),
                        ListTile(
                          leading: Radio(
                              value: 4,
                              groupValue: selChoice,
                              onChanged: (int? value) {
                                setState(() {
                                  selChoice = value!;
                                });
                              }),
                          title: Text("ตัวเลือกที่ 4"),
                        ),
                      ],
                    ),
                    Center(
                      child: ElevatedButton(
                          onPressed: () {
                            checkAnswer();
                          },
                          child: Text("ตรวจคำตอบ")),
                    )
                  ]),
                ]),
          ),
        ));
  }

  void checkAnswer() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ตัวเลือกที่เลือกคือ $selChoice"),
          );
        });
  }
}

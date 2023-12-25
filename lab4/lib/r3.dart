import 'dart:convert';

import 'package:flutter/material.dart';

class r3 extends StatefulWidget {
  const r3({super.key});

  @override
  State<r3> createState() => _r3State();
}

class _r3State extends State<r3> {
  String name = "", home = "";
  var userJson = '{"key1": "Rapee","key2": "Chachoengsao"}';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: () => loadJson(),
                child: const Text("Load Json")),
            Center(
                child: Text(
              "Name: $name",
              style: TextStyle(fontSize: 26),
            )),
            Center(
                child: Text("My Home Town: $home",
                    style: TextStyle(fontSize: 26))),
          ],
        ),
      ),
    );
  }

  void loadJson() {
    Map<String, dynamic> userdata = jsonDecode(userJson);
    setState(() {
      name = userdata["key1"];
      home = userdata["key2"];
    });
  }
}

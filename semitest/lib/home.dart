import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('หน้าหลัก',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () {}, child: Text("จัดการประเภท")),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: () {}, child: Text("จัดการสินค้า")),
        )
      ]),
    );
  }
}

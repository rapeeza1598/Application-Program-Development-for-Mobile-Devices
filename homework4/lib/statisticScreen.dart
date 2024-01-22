import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  int menu1 = 0;
  int menu2 = 0;
  int menu3 = 0;
  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      menu1 = (prefs.getInt('m1') ?? 0);
      menu2 = (prefs.getInt('m2') ?? 0);
      menu3 = (prefs.getInt('m3') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Static",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("1. Camera Capture = $menu1"),
            Text("2. Select Image for Gallery = $menu2"),
            Text("3. QR Code Scanner = $menu3"),
            ElevatedButton(
                onPressed: () {
                  resetData();
                },
                child: const Text("Reset All Data"))
          ],
        ),
      ),
    );
  }

  void resetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      menu1 = 0;
      menu2 = 0;
      menu3 = 0;
      prefs.setInt('m1', menu1);
      prefs.setInt('m2', menu2);
      prefs.setInt('m3', menu3);
    });
  }
}

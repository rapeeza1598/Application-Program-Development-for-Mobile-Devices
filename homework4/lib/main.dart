import 'package:flutter/material.dart';
import 'package:homework4/cameraScreen.dart';
import 'package:homework4/statisticScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menus',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Menus'),
      // home: const CameraScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Select the option"),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CameraScreen(),
        ),
      );
                }, child: const Text("Go to Camera Center")),
            ElevatedButton(onPressed: () {Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const StatisticScreen(),
        ),
      );}, child: const Text("Show Statistic"))
          ],
        ),
      ),
    );
  }
}

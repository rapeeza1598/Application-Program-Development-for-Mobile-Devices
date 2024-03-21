import 'package:flutter/material.dart';
import 'package:lab10/mybio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _counter = 0;
  
  @override
  void initState() {
    loadCounter();
    super.initState();
  }
  void loadCounter() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _counter = (pref.getInt('couter') ?? 0);
    });
  }
  void _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('couter') ?? 0) + 1;
      prefs.setInt('couter', _counter);
    });
  }
  void _decrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('couter') ?? 0) - 1;
      prefs.setInt('couter', _counter);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Home', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: ()=> _decrementCounter(), icon: const Icon(Icons.exposure_minus_1)),
                Text('$_counter', style: Theme.of(context).textTheme.headline4),
                IconButton(onPressed: ()=> _incrementCounter(),icon: const Icon(Icons.plus_one)),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MyBio()),
                      (route) => false);
                },
                child: const Text("Log Out"))
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My App'),
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
  int _counter = 0;
  final List<String> _imgUrl = [
    "https://media.idownloadblog.com/wp-content/uploads/2023/10/M3-MacBook-Pro-Wallpaper-8K-1500x1000.png",
    "https://media.idownloadblog.com/wp-content/uploads/2023/10/M3-M3-Pro-and-M3-Max.png"
  ];
  int _imgnumber = 0;
  void _incrementCounter() {
    setState(() {
      if (_counter < 99) _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  void _setzero() {
    setState(() {
      _counter = 0;
    });
  }

  void _setnumberimg() {
    setState(() {
      _imgnumber = 1;
    });
  }

  void _setnumberimg1() {
    setState(() {
      _imgnumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Row(
            children: [Icon(Icons.person), Text("My Home Page")],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(_imgUrl[_imgnumber]),
            const Text(
              'Hello',
              style: TextStyle(fontSize: 45, color: Colors.deepPurple),
            ),
            Text(
              '$_counter',
              // style: Theme.of(context).textTheme.headlineMedium,
              style: const TextStyle(fontSize: 75),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Row(
                      children: [
                        Icon(Icons.one_k_plus, color: Colors.amberAccent),
                        Text("เพิ่ม",
                            style: TextStyle(color: Colors.lightBlueAccent)),
                      ],
                    )),
                ElevatedButton(
                    onPressed: _decrementCounter,
                    child: const Row(
                      children: [
                        Icon(Icons.one_x_mobiledata, color: Colors.tealAccent),
                        Text("ลดค่า",
                            style: TextStyle(
                                color: Color.fromARGB(255, 44, 135, 61)))
                      ],
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _setzero,
                    child: const Row(
                      children: [
                        Icon(Icons.airline_seat_recline_normal_sharp,
                            color: Color.fromARGB(255, 177, 255, 100)),
                        Text("รีเซตเป็น 0",
                            style: TextStyle(
                                color: Color.fromARGB(255, 135, 79, 44)))
                      ],
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _setnumberimg1,
                    child: const Row(
                      children: [
                        Icon(Icons.access_alarms_sharp,
                            color: Color.fromARGB(255, 255, 100, 100)),
                        Text("ภาพที่1")
                      ],
                    )),
                ElevatedButton(
                    onPressed: _setnumberimg,
                    child: const Row(children: [
                      Icon(Icons.auto_mode_sharp,
                          color: Color.fromARGB(255, 34, 31, 87)),
                      Text("ภาพที่2")
                    ]))
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

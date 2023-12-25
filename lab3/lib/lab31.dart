import 'package:flutter/material.dart';

class Lab3_1 extends StatefulWidget {
  const Lab3_1({super.key});

  @override
  State<Lab3_1> createState() => _Lab3_1State();
}

class _Lab3_1State extends State<Lab3_1> with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Tab> mytab = [
    const Tab(
      icon: Icon(Icons.home),
    ),
    const Tab(icon: Icon(Icons.zoom_in)),
    const Tab(icon: Icon(Icons.settings)),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: mytab.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TabBar Simple"),
        backgroundColor: Colors.redAccent,
        bottom: TabBar(controller: _tabController, tabs: mytab),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  size: 200,
                  color: Colors.red,
                ),
                Text(
                  "Home",
                  style: TextStyle(
                      backgroundColor: Colors.amberAccent, fontSize: 25),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.zoom_in,
                  size: 200,
                  color: Colors.purple,
                ),
                Text(
                  "Zoom in",
                  style: TextStyle(
                      backgroundColor: Colors.lightGreenAccent, fontSize: 25),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.settings,
                  size: 200,
                  color: Colors.blueAccent,
                ),
                Text(
                  "Seting",
                  style: TextStyle(
                      backgroundColor: Color.fromARGB(255, 4, 217, 93), fontSize: 25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

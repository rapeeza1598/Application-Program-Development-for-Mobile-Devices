import 'package:flutter/material.dart';

class Lab32 extends StatefulWidget {
  const Lab32({super.key});

  @override
  State<Lab32> createState() => _Lab32State();
}

class _Lab32State extends State<Lab32> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double pi = 3.14;
  List<Tab> mytab = [
    const Tab(
      icon: Icon(Icons.home),
      text: "Home",
    ),
    const Tab(
      icon: Icon(Icons.image),
      text: "Image",
    ),
    const Tab(
      icon: Icon(Icons.settings),
      text: "Settings",
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: mytab.length,
        vsync: this,
        animationDuration: const Duration(seconds: 2));
  }

  _View() {
    return AnimatedBuilder(
        animation: _tabController.animation as Animation<double>,
        builder: (BuildContext context, snapshot) {
          return Transform.rotate(
              angle: _tabController.animation!.value * pi,
              child: [
                Container(
                  color: Colors.amberAccent,
                  child: const Center(
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
                              backgroundColor: Colors.amberAccent,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 64, 210, 255),
                  child: const Center(
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
                              backgroundColor: Colors.lightGreenAccent,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: const Color.fromARGB(255, 64, 255, 67),
                  child: const Center(
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
                              backgroundColor: Color.fromARGB(255, 4, 217, 93),
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                )
              ][_tabController.animation!.value.round()]);
        });
  }

  _appbar() {
    return TabBar(
      tabs: mytab,
      controller: _tabController,
      labelColor: Colors.greenAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppBar Simple2"),
        bottom: _appbar(),
      ),
      body: _View(),
    );
  }
}

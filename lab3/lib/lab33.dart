import 'package:flutter/material.dart';

class Lab33 extends StatefulWidget {
  const Lab33({super.key});

  @override
  State<Lab33> createState() => _Lab33State();
}

class _Lab33State extends State<Lab33> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOption = [
    Text("Index 0: Home", style: optionStyle),
    Text("Index 1: Business", style: optionStyle),
    Text("Index 2: School", style: optionStyle),
  ];

  void _onitemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buttom NavigationBar Simple")),
      backgroundColor: Colors.amber[120],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: Icon(
          Icons.window,
          size: 50,
          color: Colors.white,
        ),
      ),
      body: Center(child: _widgetOption.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 9.0,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Padding(padding: EdgeInsets.only(left:1)),
            IconButton(onPressed: (){}, icon: Icon(Icons.home)),
            IconButton(onPressed: (){}, icon: Icon(Icons.business)),
            Padding(padding: EdgeInsets.only(left: 1.0,right:1.0)),
            IconButton(onPressed: (){}, icon: Icon(Icons.school)),
            IconButton(onPressed: (){}, icon: Icon(Icons.access_alarm)),
          ],)
        // [
        //   BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        //   BottomNavigationBarItem(
        //       icon: Icon(Icons.business), label: "Business"),
        //   BottomNavigationBarItem(icon: Icon(Icons.school), label: "School"),
        // ],
        // currentIndex: _selectedIndex,
        // selectedItemColor: Colors.deepPurpleAccent,
        // onTap: _onitemTapped,
      ),
    );
  }
}

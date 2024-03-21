import 'package:final_exam/noti.dart';
import 'package:flutter/material.dart';

List<String> list = <String>['1','5', '10'];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _controller = TextEditingController();
  String dropdownValue = list.first;
  @override
  void initState() {
    Noti();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Show all notifications",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownMenu<String>(
                initialSelection: list.first,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries:
                    list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
              ElevatedButton(
                  onPressed: () {
                    Noti().ScheduleNotiSec(int.parse(dropdownValue));
                  },
                  child: const Text("Set Notification")),
              ElevatedButton(
                  onPressed: () {
                    Noti().show_noti();
                  },
                  child: const Text("Test Notification"))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text("Add Notification"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("Set the time for the notification"),
                          TextField(
                            decoration: const InputDecoration(
                              labelText: "Time",
                              hintText: "Enter the time",
                            ),
                            controller: _controller,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              list.add(_controller.text);
                              setState(() {
                                _controller.clear();
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          )
                        ],
                      ),
                    ));
          },
          backgroundColor: Colors.orangeAccent,
          child: const Icon(Icons.add),
        ));
  }
}

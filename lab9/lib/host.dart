import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HostTest extends StatefulWidget {
  const HostTest({super.key});

  @override
  State<HostTest> createState() => _HostTestState();
}

class _HostTestState extends State<HostTest> {
  dynamic data = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Host",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                data = await fetch_data();
                setState(() {});
              },
              child: const Text("Show List")),
          Expanded(
            // Wrap SingleChildScrollView with Expanded
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  data.isEmpty ? const Text("No Data") : todo_list(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          todo_adduser();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  fetch_data() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/user'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to Load Data");
    }
  }

  Widget todo_list() {
    return Column(
      children: data.map<Widget>((user) {
        return Card(
          child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: Text("${user[0]} ${user[1]}"),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          showDialog(context: context, builder: (context)=>AlertDialog(
                            title: const Text("Update User"),
                            content: TextField(
                              controller: TextEditingController(text: user[1]),
                              onChanged: (value) {
                                user[1] = value;
                              },
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    update_user(user[1], user[0]);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("OK")),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("Cancel"))
                            ],
                          ));
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Delete User"),
                                  content: const Text("Are you sure?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          delete_user(user[0]);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("OK")),
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text("Cancel"))
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              )),
        );
      }).toList(),
    );
  }

  Future<void> todo_adduser() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _nameController = TextEditingController();
          return AlertDialog(
            title: const Text("User Register"),
            content: SingleChildScrollView(
              child: ListBody(children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: "Enter Name", labelText: "Name"),
                )
              ]),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    add_user(_nameController.text);
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  void add_user(String name) async {
    Map mydata = {'name': name};
    var body = jsonEncode(mydata);
    var response = await http.post(Uri.http('127.0.0.1:8000', 'user'),
        headers: {"Content-Type": "application/json"}, body: body);
    data = await fetch_data();
    setState(() {});
  }

  Future<void> update_user(String name, int id) async {
    Map mydata = {'name': name};
    var body = jsonEncode(mydata);
    http.put(Uri.http('127.0.0.1:8000', 'user/$id'),
        headers: {"Content-Type": "application/json"}, body: body);
    data = await fetch_data();
    setState(() {});
  }

  Future<void> delete_user(int id) async {
    http.delete(Uri.http('127.0.0.1:8000', 'user/$id'));
    data = await fetch_data();
    setState(() {});
  }
}

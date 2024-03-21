import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mydata.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Add Data',style: TextStyle(fontSize: 30),),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Data',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<MyData>().add(_controller.text);
                  Navigator.pop(context, 'Hello');
                },
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
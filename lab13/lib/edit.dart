import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mydata.dart';

class EditPage extends StatelessWidget {
  final int index;
  const EditPage(this.index,{super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    _controller.text = context.read<MyData>().data[index];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Data', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Add Data',style: TextStyle(fontSize: 30),),
              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Enter Data',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<MyData>().updata(index, _controller.text);
                  Navigator.pop(context);
                },
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lab13/mydata.dart';
import 'package:provider/provider.dart';

import 'add.dart';
import 'edit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var myData = context.watch<MyData>().data;

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Demo', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purpleAccent,
      ),
      body: ListView.builder(
        itemCount: myData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(myData[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<MyData>().remove(index);
              },
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditPage(index)));
            }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

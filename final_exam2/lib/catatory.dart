import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'database_helper.dart';

class Catagory extends StatefulWidget {
  const Catagory({super.key});

  @override
  State<Catagory> createState() => _CatagoryState();
}

class _CatagoryState extends State<Catagory> {
  List<Map<String, dynamic>> _category = [];
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _loadCategory();
    super.initState();
  }

  _loadCategory() async {
    var data = await DatabaseHelper().getCategory();
    setState(() {
      _category = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("จัดกสนประเภท"),
        backgroundColor: Colors.amberAccent,
      ),
      body: Column(
        children: [
          const Text(
            "CRUD จัดการประเภท",
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
              child: _category.isNotEmpty
                  ? _myCategoryList()
                  : const Center(
                      child: Text("ไม่มีข้อมูล"),
                    ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _nameController.clear();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("เพิ่มประเภท"),
                    content: TextField(
                      controller: _nameController,
                      decoration:
                          const InputDecoration(hintText: "ป้อนชื่อประเภท"),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            DatabaseHelper()
                                .insertCategory(_nameController.text);
                            Navigator.pop(context);
                            _loadCategory();
                          },
                          child: const Text("Ok")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("close"))
                    ],
                  ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  _myCategoryList() {
    return ListView.builder(
      itemCount: _category.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_category[index]['type_code'] ?? 'No name'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _nameController.text = _category[index]['type_code'];
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("แก้ไขประเภท"),
                            content: TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  hintText: _category[index]['name']),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    DatabaseHelper().updateCategory(
                                        _category[index]['id'],
                                        _nameController.text);
                                    Navigator.pop(context);
                                    _loadCategory();
                                  },
                                  child: const Text("Ok")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("close"))
                            ],
                          ));
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("ลบประเภท"),
                            content: Text(
                                "คุณต้องการลบ ${_category[index]['name']} ใช่หรือไม่"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    DatabaseHelper()
                                        .deleteCategory(_category[index]['id']);
                                    Navigator.pop(context);
                                    _loadCategory();
                                  },
                                  child: const Text("Ok")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("close"))
                            ],
                          ));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

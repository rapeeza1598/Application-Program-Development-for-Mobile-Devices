import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Fbtest extends StatefulWidget {
  const Fbtest({super.key});

  @override
  State<Fbtest> createState() => _FbtestState();
}

class _FbtestState extends State<Fbtest> {
  late TextEditingController _nameController;
  late TextEditingController _jobController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _jobController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Test'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: StreamBuilder(
          //loading
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                print(document.id);
                return Card(
                    child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(document['name']),
                  subtitle: Text(document['job']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // _deleteFromFirebase(document.id);
                      if (document['canDelete'] == true) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete User'),
                              content: Text(
                                  'Are you sure you want to delete ${document['name']}?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _deleteFromFirebase(document.id);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          });
                      }
                      else{
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text('You can not delete this user'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                  ),
                ));
              }).toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Add User'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: _jobController,
                        decoration: const InputDecoration(labelText: 'Job'),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _insartToFirebase(
                            _nameController.text, _jobController.text);
                        _nameController.clear();
                        _jobController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              });
          // _insartToFirebase();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _insartToFirebase(String name, String job) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference users = db.collection('users');
    final Map<String, dynamic> userData = <String, dynamic>{
      'name': name,
      'job': job,
      'canDelete': 'true'
    };
    await users.doc().set(userData);
    setState(() {});
  }

  void _deleteFromFirebase(String name) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference users = db.collection('users');
    await users.doc(name).delete();
    setState(() {});
  }

  void _updateToFirebase(String id,String name, String job) async {
    _nameController.text = name;
    _jobController.text = job;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    final CollectionReference users = db.collection('users');
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _jobController,
              decoration: const InputDecoration(labelText: 'Job'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final Map<String, dynamic> userData = <String, dynamic>{
                'name': _nameController.text,
                'job': _jobController.text,
              };
              users.doc(id).update(userData);
              _nameController.clear();
              _jobController.clear();
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      );
    });
  }
}

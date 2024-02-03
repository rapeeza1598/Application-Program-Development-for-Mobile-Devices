import 'package:flutter/material.dart';
import 'package:lab7/book.dart';

class DbTest extends StatefulWidget {
  const DbTest({super.key});

  @override
  State<DbTest> createState() => _DbTestState();
}

class _DbTestState extends State<DbTest> {
  String txt = "DB Example\n";
  List<Map<String, dynamic>> mybooks = [
    {
      "id": 1,
      "title": 'The Great Gatsby',
      "author": 'F. Scott Fitzgerald',
      "rating": 4.5,
    },
    {
      "id": 2,
      "title": 'One Hundred Years of Solitude',
      "author": 'Gabriel Garcia Marquez',
      "rating": 4.9,
    },
    {
      "id": 3,
      "title": 'A Passage to India',
      "author": 'E.M. Forster',
      "rating": 4.7,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DB Test'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Column(children: [
          Text(txt),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    loaddata();
                    setState(() {
                      txt = txt;
                    });
                  },
                  child: const Text("Load Data")),
              ElevatedButton(
                  onPressed: () {
                    readData();
                    setState(() {
                      txt = txt;
                    });
                  },
                  child: const Text("Read Data")),
            ],
          ),
          // SizedBox(
          //   height: 200,
          //   child: ListView.builder(
          //       itemCount: mybooks.length,
          //       itemBuilder: (context, index) {
          //         return ListTile(
          //           title: Text(mybooks[index]['title']),
          //           subtitle: Text(mybooks[index]['author']),
          //         );
          //       }),
          // )
          Column(
            children: [
              SizedBox(
                  height: 500,
                  child: SingleChildScrollView(
                    child: bulidlist(),
                  ))
            ],
          )
        ]),
      ),
    );
  }

  void loaddata() {
    txt += "${mybooks[0]['title']}\n";
  }

  void readData() {
    List<Book> books = mybooks.map((e) => Book.fromJson(e)).toList();
    for (int i = 0; i < books.length; i++) {
      Book book = books[i];
      txt += "${book.title}\n";
    }
  }

  Widget bulidlist() {
    return Column(
      children: mybooks
          .map((json) => Card(
                  child: ListTile(
                leading: CircleAvatar(child: Text(json['id'].toString()),),
                title: Text(json['title']),
                subtitle: Text(json['author']),
                trailing: SizedBox(
                  // color: Colors.purpleAccent,
                  width: 100,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {}),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              )))
          .toList(),
    );
  }
}

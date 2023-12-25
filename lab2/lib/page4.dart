import 'dart:math';

import 'package:flutter/material.dart';

class Products {
  final String name;
  final int price;

  const Products({required this.name, required this.price});
}

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  List<Products> products = List.generate(
      20,
      (index) =>
          Products(name: "Item $index", price: Random().nextInt(10) * 100));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Select Item"),
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Color.fromARGB(255, 255, 255, 255)),
      body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Product : ${products[index].name}"),
              subtitle: Text("Price : ${products[index].price}"),
              onTap: () {
                todo(products[index].name,products[index].price);
              },
            );
          }),
    );
  }

  void todo(String name, int price) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Product $name"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [const Text("Image"), Text("Price : $price")],
          ),
          actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK")),
            ],
        );
      },
    );
  }
}

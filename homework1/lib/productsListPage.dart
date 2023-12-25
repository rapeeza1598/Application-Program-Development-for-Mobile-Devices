import 'dart:math';
import 'package:flutter/material.dart';
import 'package:homework1/pruductsView.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({Key? key}) : super(key: key);

  @override
  State<ProductsListPage> createState() => _ProductsState();
}

class Products {
  final String productLogo;
  final String productName;
  final int price;

  Products({
    required this.productLogo,
    required this.productName,
    required this.price,
  });
}

class _ProductsState extends State<ProductsListPage> {
  late List<Products> products;

  @override
  void initState() {
    super.initState();
    products = List.generate(
      20,
      (index) => Products(
        productLogo: "https://i.dummyjson.com/data/products/${index + 1}/thumbnail.jpg",
        productName: "$index",
        price: Random().nextInt(100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.network(
                        products[index].productLogo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text("MyProduct ${products[index].productName}"),
                  subtitle: Text("Price : ${products[index].price}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductView(
                          products[index]
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 45,
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white),
              onPressed: () {},
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}

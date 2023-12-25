import 'package:flutter/material.dart';
import 'package:homework1/productsListPage.dart';

class ProductView extends StatefulWidget {
  final Products product;

  const ProductView(this.product, {Key? key}) : super(key: key);

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  Widget build(BuildContext context) {
    var product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Index ${product.productName}"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(product.productLogo),
          Text("Product Name : ${product.productName}",
              style: const TextStyle(fontSize: 40)),
          Text("Price : ${product.price} \$",style: const TextStyle(fontSize: 30),),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text("Back"),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'database_helper.dart';

class ShowProductWithCategory extends StatefulWidget {
  const ShowProductWithCategory({super.key});

  @override
  State<ShowProductWithCategory> createState() =>
      _ShowProductWithCategoryState();
}

class _ShowProductWithCategoryState extends State<ShowProductWithCategory> {
  String? _selectedItem;
  String? _selectedItem2;
  List<Map<String, dynamic>> _category = [];
  List<Map<String, dynamic>> _product = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _remainController = TextEditingController();

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

  _showProductByCategory(String _selectedItem) async {
    var data = await DatabaseHelper().getProductByCategory(_selectedItem);
    setState(() {
      _product = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("แสดงสินค้าตามประเภท"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDropDown(),
              ElevatedButton(
                  onPressed: () {
                    _showProductByCategory(_selectedItem!);
                  },
                  child: const Text("show product by category"))
            ],
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _product.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text("${_product[index]['product_id']}"),
                  ),
                  title: Text(_product[index]['name'].toString()),
                  subtitle: Text(_product[index]['category_id'].toString()),
                  trailing: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text("ลบสินค้า"),
                                      content: Text(
                                          "ต้องการลบ ${_product[index]['name']} หรือไม่?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              int productId = int.parse(
                                                  _product[index]['id']
                                                      .toString());
                                              DatabaseHelper()
                                                  .deleteProduct(productId);
                                              Navigator.pop(context);
                                              _showProductByCategory(
                                                  _selectedItem!);
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
                          icon: const Icon(Icons.delete))
                    ],
                  ),
                ),
              );
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("เพิ่มสินค้า"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration:
                              const InputDecoration(hintText: "ชื่อสินค้า"),
                        ),
                        const Text("ประเภท"),
                        DropdownMenuItem(child: _buildDropDown()),
                        TextField(
                          controller: _priceController,
                          decoration:
                              const InputDecoration(hintText: "ราคาสินค้า"),
                        ),
                        TextField(
                          controller: _stockController,
                          decoration:
                              const InputDecoration(hintText: "จำนวนสินค้า"),
                        ),
                        TextField(
                          controller: _remainController,
                          decoration: const InputDecoration(
                              hintText: "จำนวนสินค้าคงเหลือ"),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            DatabaseHelper().insertProduct(
                              _nameController.text,
                              _selectedItem!,
                              _priceController.text != null
                                  ? int.parse(_priceController.text)
                                  : 0,
                              _stockController.text != null
                                  ? int.parse(_priceController.text)
                                  : 0,
                              _remainController.text != null
                                  ? int.parse(_priceController.text)
                                  : 0,
                            );
                            Navigator.pop(context);
                            _showProductByCategory(_selectedItem!);
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

  Widget _buildDropDown() {
    return DropdownButton<String>(
      value: _selectedItem,
      items: _category.map((value) {
        return DropdownMenuItem<String>(
          value: value['id'].toString(),
          child: Text(value['type_code'].toString()),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedItem = value;
        });
      },
    );
  }
}

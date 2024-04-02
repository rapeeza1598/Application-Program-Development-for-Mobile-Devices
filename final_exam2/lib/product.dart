import 'package:final_exam2/showproductwithcata.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'database_helper.dart';

class MangeProduct extends StatefulWidget {
  const MangeProduct({super.key});

  @override
  State<MangeProduct> createState() => _MangeProductState();
}

class _MangeProductState extends State<MangeProduct> {
  List<Map<String, dynamic>> _product = [];

  _getProductRemainLow() async {
    var data = await DatabaseHelper().getLowRemain();
    setState(() {
      _product = data;
    });
  }

  _getProductHighestPrice() async {
    var data = await DatabaseHelper().getHighestPrice();
    setState(() {
      _product = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("จัดการสินค้า"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ShowProductWithCategory())),
                      child: const Text("แสดงสินค้าตามประเภท")),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _getProductRemainLow();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                                "ยอดสรุปสินค้าที่เหลือน้อย 5 อันดับ"),
                            content: Container(
                              width: double.maxFinite,
                              height:
                                  300,
                              child: ListView.builder(
                                itemCount: _product.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(
                                        _product[index]['name'].toString()),
                                    subtitle: Text(
                                        "เหลือ ${_product[index]['remain']} ชิ้น"),
                                  );
                                },
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Ok"),
                              ),
                            ],
                          ),
                        );
                      },
                      child:
                          const Text("แสดงยอดสรุปสินค้าที่เหลือน้อย 5 อันดับ")),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _getProductHighestPrice();
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                                "ยอดสรุปสินค้าที่เหลือน้อย 5 อันดับ"),
                            content: Container(
                              width: double.maxFinite,
                              height:
                                  300,
                              child: ListView.builder(
                                itemCount: _product.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(
                                        _product[index]['name'].toString()),
                                    subtitle: Text(
                                        "เหลือ ${_product[index]['remain']} ชิ้น"),
                                  );
                                },
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Close'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text("แสดงสินค้าราคาแพงที่สุด 3 ลำดับ")),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

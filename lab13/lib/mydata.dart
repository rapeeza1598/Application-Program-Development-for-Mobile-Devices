import 'package:flutter/material.dart';

class MyData with ChangeNotifier{
  List<String> _data = ['Hello World!','HOHO','HAHA'];

  void add(String text){
    _data.add(text);
    notifyListeners();
  }

  void updata(int index, String text){
    _data[index] = text;
    notifyListeners();
  }

  void remove(int index){
    _data.removeAt(index);
    notifyListeners();
  }

  List<String> get data => _data;
}
import 'package:flutter/material.dart';
import 'package:lab13/mydata.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => MyData(), child: const MaterialApp(home: HomePage())));
}

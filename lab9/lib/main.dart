import 'package:flutter/material.dart';
import 'package:lab9/host.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HostTest());
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_dev/src/views/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BoardingView(),
    );
  }
}

import 'package:alpha_flutter_project/feature/bloc_practice/presentation/page/counter_1_page.dart';
import 'package:alpha_flutter_project/feature/bloc_practice/presentation/page/counter_2_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:CounterPage2()
    );
  }
}
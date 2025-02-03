import 'package:alpha_flutter_project/counter/view/counter_page.dart';
import 'package:flutter/material.dart';
import "package:alpha_flutter_project/home/home.dart";

class CounterApp extends StatelessWidget {
  static final String route = "/counter-app";

  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
      selectedRoute: CounterApp.route,
      body:CounterPage()
    );
  }
}

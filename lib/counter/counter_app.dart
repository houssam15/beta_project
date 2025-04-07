import 'package:alpha_flutter_project/common/src/layouts/feature_layout.dart';
import 'package:alpha_flutter_project/counter/view/counter_page.dart';
import 'package:flutter/material.dart';
import "../common/common.dart";
import 'counter_app_params.dart';
class CounterApp extends StatelessWidget {
  static final String route = "/counter-app";

  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureLayout<CounterAppParams>(
        child: CounterPage(),
        params: CounterAppParams().create(),
        selectedRoute: "/counter-app"
    );
  }

}

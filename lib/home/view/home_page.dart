import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:alpha_flutter_project/app.dart";
import "package:alpha_flutter_project/home/home.dart";
import "package:weather_repository/weather_repository.dart" show WeatherRepository;
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /*static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }*/

  NavigatorState get _navigator => navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("dashboard")
        ],
      ),
    );
  }
}

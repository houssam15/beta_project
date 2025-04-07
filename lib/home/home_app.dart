import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:alpha_flutter_project/home/home.dart";
import "package:weather_repository/weather_repository.dart" show WeatherRepository;
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import "../common/common.dart";
import "home_app_params.dart";
class HomeApp extends StatefulWidget {
  static final String route = "/";
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return FeatureLayout<HomeAppParams>(
      selectedRoute: "/",
      params: HomeAppParams().create(),
      child: HomePage()
    );


  }
}

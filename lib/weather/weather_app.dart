import 'package:alpha_flutter_project/common/common.dart';
import 'package:alpha_flutter_project/weather/weather.dart';
import 'package:alpha_flutter_project/weather/weather_app_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_repository/weather_repository.dart'
    show WeatherRepository;
import 'package:weather_repository/weather_repository.dart'
    show WeatherCondition;

import 'package:google_fonts/google_fonts.dart';
import "package:alpha_flutter_project/home/home.dart";

class WeatherApp extends StatelessWidget {
  static final String route = "/weather";
  const WeatherApp({ super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherCubit(WeatherRepository()),
      child: const WeatherAppView(),
    );
  }
}

class WeatherAppView extends StatelessWidget {
  const WeatherAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final seedColor = context.select(
          (WeatherCubit cubit) => cubit.state.weather.toColor
    );
   /* return
      HomeLayout(
        selectedRoute:WeatherApp.route,
        body: MaterialApp(
          debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
          textTheme:GoogleFonts.rajdhaniTextTheme()
        ),
        home: const WeatherPage(),
            ),
      );*/

    return FeatureLayout<WeatherAppParams>(
        params: WeatherAppParams().create(),
        selectedRoute: "/weather",
        child: Container(child: WeatherPage(),)
    );
  }
}

extension on Weather {
  Color get toColor {
    switch (condition) {
      case WeatherCondition.clear:
        return Colors.yellow;
      case WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case WeatherCondition.cloudy:
        return Colors.blueGrey;
      case WeatherCondition.rainy:
        return Colors.indigoAccent;
      case WeatherCondition.unknown:
        return Colors.cyan;
    }
  }
}
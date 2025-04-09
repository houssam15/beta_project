import 'package:alpha_flutter_project/app.dart';
import 'package:alpha_flutter_project/weather/cubit/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:alpha_flutter_project/settings/settings.dart";
import "package:alpha_flutter_project/search/search.dart";
import "package:alpha_flutter_project/weather/widgets/widgets.dart";

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  NavigatorState get _navigator => navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => _navigator.push<void>(
                  SettingsPage.route(weatherCubit: context.read<WeatherCubit>())),
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                return switch (state.status) {
                  WeatherStatus.initial => const WeatherEmpty(),
                  WeatherStatus.loading => const WeatherLoading(),
                  WeatherStatus.failure => const WeatherError(),
                  WeatherStatus.success => WeatherPopulated(
                    weather: state.weather,
                    units: state.temperatureUnits,
                    onRefresh: () {
                      return context.read<WeatherCubit>().refreshWeather();
                    },
                  ),
                };
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              child: const Icon(Icons.search, semanticLabel: 'Search'),
              onPressed: () async {
                final city = await Navigator.of(context).push(SearchPage.route());
                if (!context.mounted) return;
                await context.read<WeatherCubit>().fetchWeather(city);
              },
            ),
          ),
        ),
      ],
    );
  }
}
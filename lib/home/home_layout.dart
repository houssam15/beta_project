import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:alpha_flutter_project/home/home.dart";
import "package:weather_repository/weather_repository.dart" show WeatherRepository;
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import "package:alpha_flutter_project/weather/weather.dart";
import "package:alpha_flutter_project/flutter_infinite_list/infinite_list_app.dart";
import "package:alpha_flutter_project/counter/counter.dart";
class HomeLayout extends StatelessWidget {
  final Widget body;
  final String selectedRoute;
  const HomeLayout({required this.body, required this.selectedRoute,super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            route: HomeApp.route,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Learning',
            icon: Icons.leaderboard_rounded,
            children: [
              AdminMenuItem(title: 'Weather app', route: WeatherApp.route),
              AdminMenuItem(title: 'Infinite list app', route: InfiniteListApp.route),
              AdminMenuItem(title: 'Counter app', route: CounterApp.route),
            ],
          ),
        ],
        selectedRoute: selectedRoute,
        onSelected: (item) {
          if (item.route != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                item.route!, (route) => false);
          }
        },
      ),
      body: body,
    );
  }
}

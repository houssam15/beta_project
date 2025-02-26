import "package:alpha_flutter_project/file_uploader/file_uploader.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:alpha_flutter_project/home/home.dart";
import "package:weather_repository/weather_repository.dart" show WeatherRepository;
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import "package:alpha_flutter_project/weather/weather.dart";
import "package:alpha_flutter_project/flutter_infinite_list/infinite_list_app.dart";
import "package:alpha_flutter_project/counter/counter.dart";
class HomeLayout extends StatefulWidget {
  final Widget body;
  final String selectedRoute;
  const HomeLayout({required this.body, required this.selectedRoute,super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  String title = "";
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Dashboard',
            route: HomeApp.route,
            icon: Icons.dashboard,
          ),
          AdminMenuItem(
            title: 'Testing',
            icon: Icons.leaderboard_rounded,
            children: [
              AdminMenuItem(title: 'Weather app', route: WeatherApp.route),
              AdminMenuItem(title: 'Infinite list app', route: InfiniteListApp.route),
              AdminMenuItem(title: 'Counter app', route: CounterApp.route),
              AdminMenuItem(title: 'File Uploader', route: FileUploaderApp.route),
            ],
          ),
        ],
        selectedRoute: widget.selectedRoute,
        onSelected: (item) {
          if (item.route != null) {
            title = item.title;
            setState(() {});
            Navigator.of(context).pushNamedAndRemoveUntil(
                item.route!, (route) => false);
          }
        },
      ),
      body: widget.body,
    );
  }
}

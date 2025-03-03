import "package:alpha_flutter_project/social_media_file_uploader_form/social_media_file_uploader_form.dart";
import "package:flutter/material.dart";
import "package:alpha_flutter_project/home/home.dart";
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import "package:alpha_flutter_project/weather/weather.dart";
import "package:alpha_flutter_project/flutter_infinite_list/infinite_list_app.dart";
import "package:alpha_flutter_project/counter/counter.dart";
import "package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart";
import "package:alpha_flutter_project/social_media_list_form/social_media_list_form.dart";

class HomeLayout extends StatefulWidget {
  final Widget body;
  final String selectedRoute;
  final String title;
  const HomeLayout({
    required this.body,
    required this.selectedRoute,
    this.title = " App & Features",
    super.key
  });

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar:AppBar(
            title: Text(widget.title),
          ),
      sideBar: SideBar(
        items: [
          AdminMenuItem(title: 'Dashboard',route: HomeApp.route),
          AdminMenuItem(title: 'Weather app', route: WeatherApp.route),
          AdminMenuItem(title: 'Infinite list app', route: InfiniteListApp.route),
          AdminMenuItem(title: 'Counter app', route: CounterApp.route),
          AdminMenuItem(title: 'Social media File Uploader', route: SocialMediaFileUploaderForm.route),
          AdminMenuItem(title: 'Social media publication form', route: SocialMediaPublicationForm.route),
          AdminMenuItem(title: 'Social media list form', route: SocialMediaListForm.route),
        ],
        selectedRoute: widget.selectedRoute,
        onSelected: (item) {
          if (item.route != null) {
            //widget.title = item.title;
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

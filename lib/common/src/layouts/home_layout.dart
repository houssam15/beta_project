import "package:alpha_flutter_project/i18n_testing/src/i18n_testing.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/social_media_file_uploader_form.dart";
import "package:flutter/material.dart";
import "package:alpha_flutter_project/home/home.dart";
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import "package:alpha_flutter_project/weather/weather.dart";
import "package:alpha_flutter_project/flutter_infinite_list/infinite_list_app.dart";
import "package:alpha_flutter_project/counter/counter.dart";
import "package:alpha_flutter_project/social_media_publication_form/social_media_publication_form.dart";
import "package:alpha_flutter_project/social_media_list_form/social_media_list_form.dart";
import "package:alpha_flutter_project/social_media_publications_list/social_media_publications_list.dart";

import "../../../qrcode_list/src/qrcode_list.dart";

class HomeLayout extends StatefulWidget {
  final Widget body;
  final String selectedRoute;
  final String title;
  final bool hideAppbar;
  final bool hideSidebar;

  const HomeLayout({
    required this.body,
    required this.selectedRoute,
    this.title = " App & Features",
    this.hideAppbar = false,
    this.hideSidebar = false,
    super.key
  });

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar:widget.hideAppbar?null:AppBar(
            title: Text(widget.title),
          ),
      sideBar: widget.hideSidebar ? null: SideBar(
        items: [
          AdminMenuItem(title: 'Dashboard',route: HomeApp.route),
          AdminMenuItem(title: 'Weather app', route: WeatherApp.route),
          AdminMenuItem(title: 'Infinite list app', route: InfiniteListApp.route),
          AdminMenuItem(title: 'Counter app', route: CounterApp.route),
          AdminMenuItem(title: 'Social media File Uploader', route: SocialMediaFileUploaderForm.route),
          AdminMenuItem(title: 'Social media publication form', route: SocialMediaPublicationForm.route),
          AdminMenuItem(title: 'Social media list form', route: SocialMediaListForm.route),
          AdminMenuItem(title: 'I18n testing', route: I18nTesting.route),
          AdminMenuItem(title: "Social media publications list",route:SocialMediaPublicationsList.route),
          AdminMenuItem(title: "Qrcode list",route: QrcodeList.route)
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

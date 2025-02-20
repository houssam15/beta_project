import 'package:alpha_flutter_project/flutter_infinite_list/view/posts_page.dart';
import 'package:flutter/material.dart';
import "package:alpha_flutter_project/home/home.dart";


class InfiniteListApp extends StatelessWidget {
  static final String route = "/infinite-list-app";
  const InfiniteListApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
        selectedRoute: InfiniteListApp.route,
        body:PostsPage()
    );
  }
}

import 'infinite_list_app_params.dart';
import '../common/common.dart';
import 'package:alpha_flutter_project/flutter_infinite_list/view/posts_page.dart';
import 'package:flutter/material.dart';

class InfiniteListApp extends StatelessWidget {
  static final String route = "/infinite-list-app";
  const InfiniteListApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureLayout<InfiniteListAppParams>(
        selectedRoute: "/infinite-list-app",
        params: InfiniteListAppParams().create(),
        child:PostsPage()
    );
  }
}

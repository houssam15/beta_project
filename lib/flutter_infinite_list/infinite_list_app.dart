import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post_bloc.dart';
import 'infinite_list_app_params.dart';
import '../common/common.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'view/posts_list.dart';

class InfiniteListApp extends StatelessWidget {
  static final String route = "/infinite-list-app";
  const InfiniteListApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return FeatureLayout<InfiniteListAppParams>(
        selectedRoute: "/infinite-list-app",
        appBarTitle: "Infinite list",
        params: InfiniteListAppParams().create(),
        providers: [
          BlocProvider<PostBloc>(
            create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
          )
        ],
        child:PostsList()
    );
  }
}

import 'package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/switch_theme/switch_theme_bloc.bloc.dart';
import 'package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/user/user_bloc.bloc.dart';
import 'package:alpha_flutter_project/feature/bloc_practice/presentation/page/4_multi_bloc_page.dart';
import 'package:alpha_flutter_project/feature/bloc_practice/presentation/page/5_3_state_sharing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: StateSharingPage());
  }
}

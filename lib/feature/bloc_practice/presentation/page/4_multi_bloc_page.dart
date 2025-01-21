import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_bloc.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_event.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/switch_theme/switch_theme_bloc.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/switch_theme/switch_theme_event.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/user/user_bloc.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/user/user_event.bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";




class MultiBlocPage extends StatefulWidget {
  const MultiBlocPage({super.key});

  @override
  State<MultiBlocPage> createState() => _MultiBlocPageState();
}

class _MultiBlocPageState extends State<MultiBlocPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MultiBlocProvider Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<UserBloc, String>(
              builder: (context, name) {
                if (name.isNotEmpty)
                  return Text("Hello ${context.read<UserBloc>().state}");
                else
                  return Column(
                    children: [
                      Text("Get me"),
                      IconButton(
                        onPressed:
                            () => context.read<UserBloc>().add(GetMeEvent()),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  );
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  "Theme is ${context.read<ThemeBloc>().state.toString()}",
                  style: TextStyle(fontSize: 20),
                ),
                Switch(
                  value: context.read<ThemeBloc>().state == ThemeMode.light,
                  onChanged:
                      (value) =>
                          context.read<ThemeBloc>().add(SwitchThemeEvent()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


/*
import 'package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/switch_theme/switch_theme_bloc.bloc.dart';
import 'package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/user/user_bloc.bloc.dart';
import 'package:alpha_flutter_project/feature/bloc_practice/presentation/page/4_multi_bloc_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<UserBloc>(create: (context) => UserBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          home: MultiBlocPage()
        );
      },
    );
  }
}

*/
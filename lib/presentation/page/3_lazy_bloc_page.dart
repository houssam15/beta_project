
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../bloc/counter/counter_bloc.bloc.dart";
import "../bloc/counter/counter_event.bloc.dart";

class LazyBlocPage extends StatefulWidget {
  const LazyBlocPage({super.key});

  @override
  State<LazyBlocPage> createState() => _LazyBlocPageState();
}

class _LazyBlocPageState extends State<LazyBlocPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      lazy: true, // Change to false to compare behavior
      create: (context) {
        if (kDebugMode) print("Create executed");
        return CounterBloc();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Lazy Bloc Example")),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              // Access the BLoC only when the button is pressed
              BlocProvider.of<CounterBloc>(context).add(CounterIncrementPressedEvent());
              if (kDebugMode) print("lazyBloc accessed");
            },
            child: const Text("Access LazyBLoc"),
          ),
        ),
      ),
    );
  }
}

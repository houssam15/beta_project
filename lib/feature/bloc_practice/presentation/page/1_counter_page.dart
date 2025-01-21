import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_bloc.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_event.bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CounterPage1 extends StatefulWidget {
  const CounterPage1({super.key});

  @override
  State<CounterPage1> createState() => _CounterPage1State();
}

class _CounterPage1State extends State<CounterPage1> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (_) => CounterBloc(),
      child: Scaffold(
        body: BlocBuilder<CounterBloc, int>(
          buildWhen: (previous, current) {
            return current % 2 == 0;
          },
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Counter bloc $state")),
                ElevatedButton(
                  onPressed:
                      () =>
                          context.read<CounterBloc>()
                            ..add(CounterIncrementPressedEvent()),
                  child: Text("+"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

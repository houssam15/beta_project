import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_bloc.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_event.bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class CounterPage2 extends StatefulWidget {
  const CounterPage2({super.key});

  @override
  State<CounterPage2> createState() => _CounterPage2State();
}

class _CounterPage2State extends State<CounterPage2> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (_) => CounterBloc(),
      child: BlocSelector<CounterBloc, int, Color>(
        selector:
            (state) =>
                state == 0
                    ? Colors.grey
                    : (state > 0 ? Colors.green : Colors.red),
        builder: (context, color) {
          return Scaffold(
            backgroundColor: color,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocSelector<CounterBloc, int, int>(
                  selector: (state) => state,
                  builder: (context, state) {
                    return Center(child: Text("Counter value : $state"));
                  },
                ),
                BlocSelector<CounterBloc, int, String>(
                  selector: (state) => state % 2 == 0 ? "Even" : "Odd",
                  builder: (context, parity) {
                    return Center(child: Text("Parity : $parity"));
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:
                          () =>
                              context.read<CounterBloc>()
                                ..add(CounterIncrementPressedEvent()),
                      child: Text("+"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed:
                          () =>
                              context.read<CounterBloc>()
                                ..add(CounterDecrementPressedEvent()),
                      child: Text("-"),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

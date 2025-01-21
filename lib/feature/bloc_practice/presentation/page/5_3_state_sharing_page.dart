import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_bloc.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_event.bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class StateSharingPage extends StatefulWidget {
  const StateSharingPage({super.key});

  @override
  State<StateSharingPage> createState() => _StateSharingPageState();
}

class _StateSharingPageState extends State<StateSharingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocProvider<CounterBloc>(
              create: (_) => CounterBloc(),
              child: ParentCounterWidget(),
            ),
            SizedBox(height: 40),
            BlocProvider<CounterBloc>(
              create: (_) => CounterBloc(),
              child: CounterResultWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

class ParentCounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return Column(
          children: [
            Text("Parent state: ${state}"),
            ElevatedButton(
              onPressed:
                  () => context.read<CounterBloc>().add(
                    CounterIncrementPressedEvent(),
                  ),
              child: Text("Add to parent"),
            ),
          ],
        );
      },
    );
  }
}

class CounterResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return Column(
          children: [
            Text("Child state: ${state}"),
            ElevatedButton(
              onPressed:
                  () => context.read<CounterBloc>().add(
                    CounterIncrementPressedEvent(),
                  ),
              child: Text("Add to child"),
            ),
          ],
        );
      },
    );
  }
}

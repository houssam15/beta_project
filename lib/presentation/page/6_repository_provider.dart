import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

//counter repository
class CounterRepository {
  int fetchInitialCount() => 0;
}

//main page
class RepositoryProviderPage extends StatelessWidget {
  const RepositoryProviderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CounterRepository(),
      child: Scaffold(
        appBar: AppBar(title: Text("RepositoryProvider Example")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CounterWidget1(), CounterWidget2()],
        ),
      ),
    );
  }
}

//counter page 1
class CounterWidget1 extends StatefulWidget {
  const CounterWidget1({super.key});

  @override
  State<CounterWidget1> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget1> {
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<CounterRepository>(context);
    final initialCount = repository.fetchInitialCount();

    return Center(child: Text("Initial 1 Count: $initialCount"));
  }
}

//counter page 1
class CounterWidget2 extends StatefulWidget {
  const CounterWidget2({super.key});

  @override
  State<CounterWidget2> createState() => _CounterWidget2State();
}

class _CounterWidget2State extends State<CounterWidget2> {
  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<CounterRepository>(context);
    final initialCount = repository.fetchInitialCount();

    return Center(child: Text("Initial 2 Count: $initialCount"));
  }
}

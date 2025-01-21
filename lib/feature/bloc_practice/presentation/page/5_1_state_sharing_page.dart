import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_bloc.bloc.dart";
import "package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_event.bloc.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

/*
Exercise 1: Navigation with BlocProvider.value
You have a HomeScreen with an instance of CounterBloc. 
When navigating to DetailsScreen, you want to pass the same 
CounterBloc instance to maintain the state.

Task:
Complete the navigation code below to pass the existing CounterBloc to DetailsScreen using BlocProvider.value.


Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => BlocProvider.value(
      value: ____________,
      child: DetailsScreen(),
    ),
  ),
);
Question:

What should replace ____________ to correctly pass the existing bloc?
*/

class StateSharingPage extends StatefulWidget {
  const StateSharingPage({super.key});

  @override
  State<StateSharingPage> createState() => _StateSharingPageState();
}

class _StateSharingPageState extends State<StateSharingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: Scaffold(body: HomeScreen()),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("counter $state"),
              IconButton(
                onPressed: () {
                  context.read<CounterBloc>().add(
                    CounterIncrementPressedEvent(),
                  );
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider.value(
                            value: this.context.read<CounterBloc>(),
                            child: DetailsPage(),
                          ),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_right_alt),
              ),
            ],
          ),
        );
      },
    );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("state is ${context.read<CounterBloc>().state}"));
  }
}

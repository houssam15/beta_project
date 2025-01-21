import 'package:alpha_flutter_project/feature/bloc_practice/presentation/bloc/counter/counter_event.bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    if (kDebugMode) print("LazyBloc has been created");
    on<CounterIncrementPressedEvent>((event, emit) => emit(state + 1));
    on<CounterDecrementPressedEvent>((event, emit) => emit(state - 1));
  }
}

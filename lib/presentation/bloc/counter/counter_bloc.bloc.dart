import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'counter_event.bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    if (kDebugMode) print("LazyBloc has been created");
    on<CounterIncrementPressedEvent>((event, emit) => emit(state + 1));
    on<CounterDecrementPressedEvent>((event, emit) => emit(state - 1));
  }
}

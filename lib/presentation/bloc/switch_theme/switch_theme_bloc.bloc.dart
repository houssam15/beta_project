import 'package:alpha_flutter_project/presentation/bloc/switch_theme/switch_theme_event.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<SwitchThemeEvent>(
      (event, emit) =>
          emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light),
    );
  }
}

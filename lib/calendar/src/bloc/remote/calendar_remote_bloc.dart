import 'dart:math';

import 'package:alpha_flutter_project/calendar/src/models/models.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "calendar_remote_event.dart";
part "calendar_remote_state.dart";

class CalendarRemoteBloc extends Bloc<CalendarRemoteEvent,CalendarRemoteState>{
  CalendarRemoteBloc():super(CalendarRemoteState()){
    on<CalendarRemoteDataRequested>(_onDataRequested);
    on<CalendarRemoteModeChanged>(_onModeChanged);
  }

  _onDataRequested(CalendarRemoteDataRequested event,Emitter<CalendarRemoteState> emit) async {
    try{
      await Future.delayed(Duration(seconds: 1));
      emit(state.copyWith(status: CalendarRemoteStatus.success));
    }catch(err){
      emit(state.copyWith(status: CalendarRemoteStatus.failed,errorMessage: "Unexpected error"));
    }
  }

  _onModeChanged(CalendarRemoteModeChanged event,Emitter<CalendarRemoteState> emit) async {
    try{
      List<CalendarMode> modes = [];
      for(CalendarMode mode in state.calendarModes){
          mode.isSelected = mode.id == event.selectedMode.id;
          modes.add(mode);
      }
      emit(state.copyWith(status: CalendarRemoteStatus.success,calendarModes: modes).forceSend());
    }catch(err){
      emit(state.copyWith(status: CalendarRemoteStatus.failed,errorMessage: "Unexpected error"));
    }
  }
}
import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/calendar/src/bloc/remote/calendar_remote_bloc.dart";
import "package:alpha_flutter_project/calendar/src/models/calendar_success_page/calendar_mode.dart";
import "package:flutter/material.dart";
import "package:calendar_view/calendar_view.dart";
class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {

  @override
  Widget build(BuildContext context) {
    CalendarControllerProvider.of(context).controller.addAll(
      context.read<CalendarRemoteBloc>().state.events
    );
    switch (context.read<CalendarRemoteBloc>().state.getCalendarMode().value){
      case CalendarModeType.month : return MonthView();
      case CalendarModeType.week : return WeekView();
      case CalendarModeType.day : return DayView();
    }
  }
}

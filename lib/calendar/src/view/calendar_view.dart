import "package:alpha_flutter_project/calendar/src/bloc/remote/calendar_remote_bloc.dart";
import "package:calendar_view/calendar_view.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "pages/calendar_failed_page.dart";
import "pages/calendar_initial_page.dart";
import "pages/calendar_success_page.dart";

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CalendarRemoteBloc,CalendarRemoteState>(
      builder: (context, state) {
        switch(state.status){
          case CalendarRemoteStatus.initial: return CalendarInitialPage();
          case CalendarRemoteStatus.failed: return CalendarFailedPage();
          case CalendarRemoteStatus.success:  return CalendarSuccessPage();
        }
      },
      listener: (context, state) {}
    );
  }
}

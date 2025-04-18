import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/calendar/src/bloc/remote/calendar_remote_bloc.dart";
import "package:flutter/material.dart";
import "../../models/models.dart";
import "mode_button.dart";
class CalendarControllers extends StatelessWidget {
  const CalendarControllers({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: context.read<CalendarRemoteBloc>().state.calendarModes.map<Widget>(
                  (mode) => Padding(
                      padding: EdgeInsets.only(left: 6,right: 2),
                      child: ModeButton(mode: mode)
                  )
          ).toList()
        )
      ),
    );
  }
}

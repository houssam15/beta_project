import "package:alpha_flutter_project/calendar/src/widgets/widgets.dart";
import "package:calendar_view/calendar_view.dart";
import "package:flutter/material.dart";

class CalendarSuccessPage extends StatefulWidget {
  const CalendarSuccessPage({super.key});

  @override
  State<CalendarSuccessPage> createState() => _CalendarSuccessPageState();
}

class _CalendarSuccessPageState extends State<CalendarSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CalendarControllerProvider(
          controller: EventController(),
          child: Column(
            children: [
              CalendarControllers(),
              Expanded(
                  child: MyCalendar()
              )
            ],
          )
      ),
    );
  }
}

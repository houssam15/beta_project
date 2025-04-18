import "package:flutter/material.dart";
import "../../widgets/widgets.dart";

class CalendarInitialPage extends StatefulWidget {
  const CalendarInitialPage({super.key});

  @override
  State<CalendarInitialPage> createState() => _CalendarInitialPageState();
}

class _CalendarInitialPageState extends State<CalendarInitialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LoadingCalendar()
              ]
          ),
        ),
      )
    );
  }
}

import "package:flutter/material.dart";
import "../../widgets/widgets.dart";
class CalendarFailedPage extends StatefulWidget {
  const CalendarFailedPage({super.key});

  @override
  State<CalendarFailedPage> createState() => _CalendarFailedPageState();
}

class _CalendarFailedPageState extends State<CalendarFailedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(bottom:100),
            child: FailedToGetData()
        ),
      ),
    );
  }
}


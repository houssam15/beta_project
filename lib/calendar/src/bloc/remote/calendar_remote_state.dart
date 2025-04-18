part of "calendar_remote_bloc.dart";
enum CalendarRemoteStatus {
  success,failed,initial
}
class CalendarRemoteState extends Equatable{
  CalendarRemoteStatus status;
  String errorMessage;
  List<CalendarMode> calendarModes;
  List<CalendarEventData> events;

  int random = 0;

  CalendarRemoteState({
    this.status = CalendarRemoteStatus.initial,
    this.errorMessage = "",
    List<CalendarMode>? calendarModes,
    List<CalendarEventData>? events
  }):
  calendarModes = calendarModes ?? [
    CalendarMode(id:1,title: "Month",value: CalendarModeType.month, isSelected: true),
    CalendarMode(id:2,title: "Week",value: CalendarModeType.week, isSelected: false),
    CalendarMode(id:3,title: "Day", value: CalendarModeType.day,isSelected: false)
  ],
  events = [
    CalendarEventData(
        title: "Event 1",
        date: DateTime(2025,4,15)
    ),
    CalendarEventData(
      title: "Event 2",
      date: DateTime(2025,4,16),
      endDate: DateTime(2025,4,17)
    ),
  ];

  CalendarRemoteState copyWith({
    CalendarRemoteStatus? status,
    String? errorMessage,
    List<CalendarMode>? calendarModes
  }){
    return CalendarRemoteState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      calendarModes: calendarModes ?? this.calendarModes
    );
  }

  CalendarRemoteState forceSend(){
    random = Random().nextInt(100000);
    return this;
  }

  CalendarMode getCalendarMode(){
    if(calendarModes.isEmpty) return CalendarMode(id:1,title: "Month",value: CalendarModeType.month, isSelected: true);
    CalendarMode? selectedMode;
    for(CalendarMode mode in calendarModes){
      if(mode.isSelected) selectedMode = mode;
    }
    if(selectedMode==null) calendarModes.first.isSelected = true;
    return selectedMode ?? calendarModes.first;
  }

  @override
  List<Object?> get props => [status,errorMessage,calendarModes,random];

}
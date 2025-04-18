part of "calendar_remote_bloc.dart";
sealed class CalendarRemoteEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class CalendarRemoteDataRequested extends CalendarRemoteEvent{}

class CalendarRemoteModeChanged extends CalendarRemoteEvent{
  final CalendarMode selectedMode;
  CalendarRemoteModeChanged({required this.selectedMode});
}
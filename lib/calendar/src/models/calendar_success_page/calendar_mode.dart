import 'package:alpha_flutter_project/authentication/authentication.dart';
enum CalendarModeType {
  month,week,day
}

class CalendarMode extends Equatable{
  int id;
  String title;
  CalendarModeType value;
  bool isSelected;

  CalendarMode({
    required this.id,
    required this.value,
    required this.title,
    required this.isSelected
  });

  @override
  List<Object?> get props => [id,title,isSelected,value];
}
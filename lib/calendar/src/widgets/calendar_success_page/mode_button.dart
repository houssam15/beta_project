import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/calendar/src/bloc/remote/calendar_remote_bloc.dart";
import "package:flutter/material.dart";
import "../../models/models.dart";
class ModeButton extends StatelessWidget {
  const ModeButton({super.key,required this.mode});
  final CalendarMode mode;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<CalendarRemoteBloc>().add(CalendarRemoteModeChanged(selectedMode:mode)),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: mode.isSelected ? Colors.blue:Colors.grey,
          border: Border.all(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Text(mode.title,style: TextStyle(color:Colors.white,fontSize: 14,fontWeight: FontWeight.w900))
        ),
      ),
    );
  }
}

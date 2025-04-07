import "dart:async";

import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:blinking_text/blinking_text.dart";
import "package:flutter/material.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class TimePicker extends StatefulWidget {
  const TimePicker(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;
  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {

  //This timer is for keep publishTime always now or in future
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        if(widget.remoteState.publishDate.isToday() && widget.remoteState.publishTime.isInPast()){
          context.read<SocialMediaPublicationFormRemoteBloc>().add(SocialMediaPublicationFormRemotePublishTimeChanged(TimeOfDay.now()));
        }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        //color: Colors.red
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child: Text(widget.remoteState.publishTime.hour.toString().padLeft(2, '0'),style: TextStyle(color: Colors.white,fontSize: 13)))
              ),
              Container(
                width: 5,
                height: 40,
                child: Center(child: BlinkText(":",duration: Duration(seconds: 1))),
              ),
              Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child: Text(widget.remoteState.publishTime.minute.toString().padLeft(2, '0'),style: TextStyle(color: Colors.white,fontSize: 13)))
              ),
              Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Center(child: Text(widget.remoteState.publishTime.period == DayPeriod.am? "am":"pm",style: TextStyle(color: Colors.white,fontSize: 13)))
              )
            ],
          ),
          InkWell(
            onTap: () async{
              final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: widget.remoteState.publishTime,
                  initialEntryMode: TimePickerEntryMode.dial,
                  orientation:Orientation.portrait,
                  builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                          materialTapTargetSize: MaterialTapTargetSize.padded,
                          timePickerTheme: TimePickerThemeData(
                            dialBackgroundColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                            hourMinuteColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                            dayPeriodTextColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.2),
                            confirmButtonStyle: ButtonStyle(
                                backgroundColor:  MaterialStateProperty.all(Theme.of(context).colorScheme.tertiary.withOpacity(0.2)),
                                //textStyle: TextStyle(color: Colors.)
                            )
                          )
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: MediaQuery(
                          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        ),
                      )
                  ),
              );
              context.read<SocialMediaPublicationFormRemoteBloc>().add(SocialMediaPublicationFormRemotePublishTimeChanged(time));
            },
            child: Container(
                width: 40,
                height: 40,
                //margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Center(child: Icon(Icons.change_circle_rounded,color: Colors.white,))
            ),
          )
        ],
      ),
    );
  }
}

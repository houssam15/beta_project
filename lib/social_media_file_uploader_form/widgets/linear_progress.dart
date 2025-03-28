import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";
import "package:percent_indicator/linear_percent_indicator.dart";

class LinearProgress extends StatelessWidget {
  const LinearProgress(this.state,{super.key});
  final FileUploaderState state;
  @override
  Widget build(BuildContext context) {
    return new LinearPercentIndicator(
        animation: true,
        animateFromLastPercent: true,
        lineHeight: 20.0,
        animationDuration: 500,
        percent: state.progress/100,
        center: Text("${state.progress}%"),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: Theme.of(context).colorScheme.tertiary
    );
  }
}

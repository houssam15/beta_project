import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:rive_animated_icon/rive_animated_icon.dart";

class UploadingWithProgress extends StatefulWidget {
  UploadingWithProgress({super.key,this.color,required this.progress});
  Color? color;
  int? progress;

  @override
  State<UploadingWithProgress> createState() => _UploadingWithProgressState();
}

class _UploadingWithProgressState extends State<UploadingWithProgress> {

  @override
  Widget build(BuildContext context) {
    widget.color = widget.color ?? Theme.of(context).colorScheme.tertiary;

    return Center(
        child: Container(
            //width: 20,
            //height: 10,
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Icon(FontAwesomeIcons.upload,color: widget.color,),
                RiveAnimatedIcon(
                    riveIcon: RiveIcon.upload,
                    loopAnimation: true,
                    width: 30,
                    height: 30,
                    color: widget.color!,
                ),
                SizedBox(width: 2),
                Text("${widget.progress.toString()} %",style: TextStyle(color: widget.color))
              ],
            )
        )
    );
  }
}

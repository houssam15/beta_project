import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";

class Loading extends StatefulWidget {
  Loading({super.key,this.color});
  Color? color;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  Widget build(BuildContext context) {
    widget.color = widget.color ?? Theme.of(context).colorScheme.onError;

    return Center(
        child: Container(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: widget.color,
            )
        )
    );
  }
}

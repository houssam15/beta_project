import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";

class Loading extends StatelessWidget {
  final FileUploaderState state;
  Loading(this.state,{super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 10,
            height: 10,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            )
        )
    );
  }
}

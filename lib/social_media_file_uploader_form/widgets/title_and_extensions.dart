import "package:flutter/material.dart";

import "../bloc/file_uploader.bloc.dart";

class TitleAndExtensions extends StatelessWidget {
  final FileUploaderState state;
  const TitleAndExtensions(this.state,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            "Upload your file",
            style: Theme.of(context).textTheme.headlineLarge
        ),
        SizedBox(
            height: 5
        ),
        Text(
            "File should be ${state.supportedExtensions.toString()}",
            style: Theme.of(context).textTheme.titleSmall
        )
      ],
    );
  }
}

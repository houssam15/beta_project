import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

class FailureWithReset extends StatelessWidget {
  final FileUploaderState state;
  const FailureWithReset(this.state,{super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(context.tr("failure")),
            InkWell(
              onTap: (){
                context.read<FileUploaderBloc>().add(FileUploaderResetRequested());
              },
              child: Icon(Icons.refresh),
            )
          ],
       )
    );
  }
}

import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:flutter/material.dart";
import "package:image_viewer/image_viewer.dart" as image_viewer;
import "package:localization_service/localization_service.dart";
import "package:percent_indicator/linear_percent_indicator.dart";
import "package:video_viewer/video_viewer.dart";

import "../models/local_file.dart";
import "loading.dart";

class UploadFile extends StatelessWidget {
  const UploadFile(this.state,{super.key});
  final FileUploaderState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child:  state.mediaType == MediaType.picture?
                FutureBuilder(
                    future: image_viewer.ImageProvider().fromFile(state.file),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting) return Loading(state);
                      if(snapshot.data!.validateResult()==false) return Center(child: Text(context.tr("can't load picture")));
                      return image_viewer.ImageViewer(imageProvider: snapshot.data!);
                    },
                ):
                VideoViewer(),
              ),
            ),
            Expanded(
                child: Column(
                  children: [
                    if(state.isUploading)
                      Flexible(
                        child: new LinearPercentIndicator(
                        //width:80,
                        animation: true,
                        lineHeight: 20.0,
                        animationDuration: 2000,
                        percent: state.progress/100,
                        center: Text("${state.progress}%"),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Theme.of(context).colorScheme.tertiary
                  ),
                  )
                ],
              )
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed:state.isUploading ? null : (){
                        context.read<FileUploaderBloc>().add(FileUploaderUploadToServer());
                      },
                      child: state.isUploading ?Loading(state):Text("upload")
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

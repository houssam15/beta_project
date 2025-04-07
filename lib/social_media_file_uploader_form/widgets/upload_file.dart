import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/widgets/back_confirmation_dialog.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/widgets/button.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/widgets/warning_list.dart";
import "package:alpha_flutter_project/social_media_list_form/social_media_list_form.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:image_viewer/image_viewer.dart" as image_viewer;
import "package:localization_service/localization_service.dart";
import "package:percent_indicator/linear_percent_indicator.dart";
import "package:video_viewer/video_viewer.dart";
import "../../app.dart";
import "../../social_media_publication_form/src/social_media_publication_form.dart";
import "../../social_media_publication_form/src/social_media_publication_form_arguments.dart";
import "linear_progress.dart";
import "../models/local_file.dart";
import "loading.dart";
import 'package:rive_animated_icon/rive_animated_icon.dart';

class UploadFile extends StatefulWidget {
  const UploadFile(this.state,{super.key});
  final FileUploaderState state;

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  Future<image_viewer.ImageProvider>? _imageFuture;

  @override
  void initState() {
    super.initState();
    if (widget.state.mediaType == MediaType.picture) {
      if(widget.state.uploadDocumentResponse.hasPicture()){
        _imageFuture = image_viewer.ImageProvider().fromUrl(widget.state.uploadDocumentResponse.getPictureUrl());
      }else{
        _imageFuture = image_viewer.ImageProvider().fromFile(widget.state.file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(8),
                    width: double.infinity,
                    height: 300,
                    child:  widget.state.mediaType == MediaType.picture?
                    FutureBuilder(
                      future: _imageFuture,
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) return Loading(widget.state);
                        if(snapshot.data!.validateResult()==false) return Center(child: Text(context.tr("can't load picture")));
                        return image_viewer.ImageViewer(imageProvider: snapshot.data!);
                      },
                    ):
                    VideoViewer()
                ),
                if(widget.state.isUploading)
                  Container(
                    margin: EdgeInsets.all(5),
                    height: 20,
                    child:LinearProgress(widget.state),
                  ),
                if(widget.state.uploadDocumentResponse.isWarningsExist() && !widget.state.isUploading)
                  ...[
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Warnings",textAlign: TextAlign.left,style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    WarningList(widget.state)
                  ],
                if(
                  widget.state.uploadDocumentResponse.isFileUploadedSuccessfully()&&
                  !widget.state.uploadDocumentResponse.isWarningsExist()
                )
                  ...[
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RiveAnimatedIcon(
                              riveIcon: RiveIcon.check,
                              width: 30,
                              height: 30,
                              color: Theme.of(context).colorScheme.tertiary,
                              strokeWidth: 10,
                              loopAnimation: true
                          ),
                          SizedBox(width: 5),
                          Text(context.tr("File uploaded successfully"))
                        ],
                      ),
                    )
                  ]

              ],
            )
        ),
        Container(
          padding: EdgeInsets.all(8),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyButton(
                widget.state,
                title:Text(context.tr("back"),style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                onPressed: () async{
                  if(context.read<FileUploaderBloc>().modifySingleDocumentForPublication){
                    Navigator.of(context).pop();
                  }else{
                    final isBack = await showDialog<bool>(useRootNavigator: false,context: context,builder: (context) => BackConfirmationDialog(widget.state));
                    if (isBack == true) {
                      context.read<FileUploaderBloc>().add(FileUploaderResetRequested());
                    }
                  }
                },
              ),
              SizedBox(width: 5),
              if(!widget.state.uploadDocumentResponse.isFileUploadedSuccessfully())
              MyButton(
                  widget.state,
                  title: widget.state.isUploading?Loading(widget.state):Text(context.tr("upload"),style: TextStyle(
                          color: widget.state.isUploading?Theme.of(context).colorScheme.onPrimary:Theme.of(context).colorScheme.onError
                  )),
                  onPressed: widget.state.isUploading ? null : (){
                    if(context.read<FileUploaderBloc>().modifySingleDocumentForPublication){
                      context.read<FileUploaderBloc>().add(FileUploaderUploadToServerForNetwork());
                    }else{
                      context.read<FileUploaderBloc>().add(FileUploaderUploadToServer());
                    }
                  },
              ),
              if(widget.state.uploadDocumentResponse.isFileUploadedSuccessfully())
                MyButton(
                  widget.state,
                  onPressed: (){
                    if(context.read<FileUploaderBloc>().modifySingleDocumentForPublication){
                      Navigator.of(context).pop(true);
                    }else{
                      if(navigatorKey.currentContext!=null){
                        Navigator.of(navigatorKey.currentContext!).pushReplacementNamed(
                            SocialMediaPublicationForm.route,
                            arguments: SocialMediaPublicationFormArguments(
                                uploadDocumentResponse:widget.state.uploadDocumentResponse.getRepository(),
                                mediaType:widget.state.mediaType.toString(),
                                constrains: widget.state.constrains.getRepository(),
                                currentState: context.read<FileUploaderBloc>().currentState
                            )
                        );
                      }
                    }

                  },
                  title: Text(context.tr(context.read<FileUploaderBloc>().modifySingleDocumentForPublication?"Ok":"Next"),style: TextStyle(color: Theme.of(context).colorScheme.onError)),
                ),
            ],
          ),
        )
      ],
    );
  }
}

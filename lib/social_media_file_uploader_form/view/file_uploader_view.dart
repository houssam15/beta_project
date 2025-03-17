import "package:alert_banner/exports.dart";
import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/bloc/file_uploader.bloc.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/widgets/title_and_extensions.dart";
import "package:dotted_border/dotted_border.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import "../models/local_file.dart";
import "../models/permissions_state.dart";
import "../widgets/widgets.dart";
class FileUploaderView extends StatefulWidget {
  FileUploaderState state;
  FileUploaderView(this.state,{super.key});

  @override
  State<FileUploaderView> createState() => _FileUploaderViewState();
}

class _FileUploaderViewState extends State<FileUploaderView> {

  _onPermissionDenied(FileUploaderState state){
    if(kDebugMode) print(context.tr("Upload from ?"));
    if(state.permissionsState.showMessageOption==ShowMessageOptions.snackBar){
      showAlertBanner(context,
              ()=>print("TAPPED"),
          AlertBannerChild(text: context.tr("Permission denied !")),
          alertBannerLocation: AlertBannerLocation.top
      );
    }else{
      showDialog(
        useRootNavigator: false,
        context: context,
        builder: (_) => BlocProvider.value(
            value: context.read<FileUploaderBloc>(),
            child: PermissionDeniedAlertDialog(state)
        )
      );
    }
  }

  _onFailure(FileUploaderState state){
    showAlertBanner(context,
            ()=>print("TAPPED"),
        AlertBannerChild(text: state.errorMessage),
        alertBannerLocation: AlertBannerLocation.top
    );
  }

  _onProgressFailure(FileUploaderState state){
    showAlertBanner(context,
            ()=>print("TAPPED"),
        AlertBannerChild(text: state.errorMessage),
        alertBannerLocation: AlertBannerLocation.top
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TitleAndExtensions(widget.state),
                  const SizedBox(height: 30),
                  Expanded(
                      flex: 6,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [8, 8],
                        strokeCap: StrokeCap.round,
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.05)
                          ),
                          child: BlocConsumer<FileUploaderBloc,FileUploaderState>(
                              listener: (context, state) {
                                if(state.action == FileUploaderAction.permissionsDenied){
                                  _onPermissionDenied(state);
                                }
                                if(state.action == FileUploaderAction.failure){
                                  _onFailure(state);
                                }
                                if(state.action == FileUploaderAction.progressFailure){
                                  _onProgressFailure(state);
                                }
                              },
                              builder: (context, state) {
                                switch (state.status){
                                  case FileUploaderStatus.loading: return Loading(widget.state);
                                  case FileUploaderStatus.initial:
                                    context.read<FileUploaderBloc>().add(FileUploaderUploadRequested());
                                    return Container();
                                  case FileUploaderStatus.cameraOrGallery:
                                    return DualOption(
                                      state,
                                      title: context.tr("Upload from ?"),
                                      option1Action: (){
                                        context.read<FileUploaderBloc>().add(FileUploaderUploadSourceRequested(UploadSourceType.camera));
                                      },
                                      option1Icon: Icons.camera,
                                      option1Title: context.tr("Caméra"),
                                      option2Action: (){
                                        context.read<FileUploaderBloc>().add(FileUploaderUploadSourceRequested(UploadSourceType.gallery));
                                      },
                                      option2Icon: Icons.library_add_sharp,
                                      option2Title: context.tr("Gallery")
                                    );
                                  case FileUploaderStatus.pictureOrVideo:
                                    return DualOption(
                                      state,
                                      title: context.tr("Picture or video ?"),
                                      option1Action: (){
                                        context.read<FileUploaderBloc>().add(FileUploaderUploadTypeRequested(MediaType.picture));
                                      },
                                      option1Icon: Icons.image,
                                      option1Title: context.tr("Image"),
                                      option2Action: (){
                                        context.read<FileUploaderBloc>().add(FileUploaderUploadTypeRequested(MediaType.video));
                                      },
                                      option2Icon: Icons.video_camera_back,
                                      option2Title: context.tr("Video")
                                    );

                                  case FileUploaderStatus.readyToUpload:
                                    return UploadFile(state)/*Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            _progress != null
                                                ?Center(child: Text("file name : ${state.file.getFilename()}",textAlign: TextAlign.center,))
                                                :SizedBox(),
                                            SizedBox(height: 10),
                                            FutureBuilder(
                                              future: state.file.getFormattedSize(),
                                              builder: (context, snapshot) => Text("file size : ${snapshot.data}"),
                                            ),
                                            SizedBox(height: 5),
                                            _progress != null
                                                ?Text(
                                              _progressError==null? _progress!:_progressError!,
                                              style: TextStyle(
                                                  color: _progressError==null?Theme.of(context).colorScheme.tertiary:Theme.of(context).colorScheme.error
                                              ),
                                            )
                                                :TextButton(
                                                onPressed: (){
                                                  context.read<FileUploaderBloc>().add(FileUploaderUploadToServer());
                                                },
                                                child: Text("Start upload")
                                            )
                                          ]
                                      ),
                                    )*/;
                                  default : return Text("Unknown status");

                                }
                              },
                          ),
                        ),
                      )
                  )

                ],
              ),
          ),
        ),
      ),
    );
  }
}

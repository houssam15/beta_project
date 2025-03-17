import "dart:io";

import "package:alpha_flutter_project/home/home.dart";

import "../bloc/file_uploader.bloc.dart";
import "../models/models.dart";
import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'dart:math' as math;
import 'package:path/path.dart' as path;


class FileUploaderPage extends StatefulWidget {
  const FileUploaderPage({super.key});

  @override
  State<FileUploaderPage> createState() => _FileUploaderPageState();
}

class _FileUploaderPageState extends State<FileUploaderPage> {
  Config get _config => Config();
  String? _progress;
  String? _progressError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: ()=>Navigator.of(context).pushNamed(HomeApp.route),
            child: Icon(Icons.arrow_back)
        ),
        title: Text(
          "Create publication",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600
        ),
        ),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          //height: 400,
          child: Card(
              child: Padding(
                  padding:const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                              "Upload your file",
                               style: Theme.of(context).textTheme.headlineLarge
                          ),
                          SizedBox(
                            height: 5
                          ),
                          Text(
                              "File should be ${_config.supportedExtensions.toString()}",
                              style: Theme.of(context).textTheme.titleSmall
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30
                      ),
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
                              child: Center(
                                child: BlocListener<FileUploaderBloc,FileUploaderState>(
                                  listener: (context, state) {
                                    /*switch(state.status){
                                      case FileUploaderStatus.permissionsDenied:
                                        if(state.permissionsState.showMessageOption==ShowMessageOptions.snackBar){
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                  backgroundColor:Theme.of(context).colorScheme.errorContainer,
                                                  content:Text(
                                                    state.permissionsState.message,
                                                    style: TextStyle(
                                                        color: Theme.of(context).colorScheme.error
                                                    ),
                                                  )
                                              )
                                          );
                                        }else{
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title:Text(state.permissionsState.title),
                                                content: Container(
                                                  height: 100, // fixed height for the overall container
                                                child: Column(
                                                children: [
                                                Text(state.permissionsState.message),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    height: 50,
                                                  child: ListView.builder(
                                                        itemCount: state.permissionsState.permissionsNotRequestedYet.length,
                                                        itemBuilder: (context, index) => ListTile(
                                                              leading: Icon(Icons.play_arrow,color: Theme.of(context).colorScheme.secondary,size: 20),
                                                              title: Transform.translate(
                                                                offset: Offset(-10, 0),
                                                                child: Text(
                                                                  state.permissionsState.permissionsNotRequestedYet[index],
                                                                  style: TextStyle(fontSize: 13,color: Theme.of(context).colorScheme.secondary),
                                                                ),
                                                              ),
                                                          contentPadding: EdgeInsets.zero,
                                                          dense: true,
                                                          minLeadingWidth : 20,
                                                        ),
                                                     ),
                                                ),
                                                  ],
                                                ),
                                                ),
                                                actions: [
                                                    TextButton(
                                                        onPressed: () => Navigator.of(context).pop(),
                                                        child: Text("cancel")
                                                    ),
                                                    TextButton(
                                                        onPressed: (){
                                                        this.context.read<FileUploaderBloc>() .add(FileUploaderSettingsOpened());
                                                        Navigator.of(context).pop();
                                                        },
                                                        child: Text("settings")
                                                    )
                                                ],
                                              ),
                                          );
                                        }
                                    //To avoid page from sending to identical state to prevent FileUploaderBloc from ignoring them
                                    context.read<FileUploaderBloc>().add(FileUploaderUploadRequested());

                                      case  FileUploaderStatus.failure :
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                backgroundColor:Theme.of(context).colorScheme.errorContainer,
                                                content:Text(
                                                  state.errorMessage,
                                                  style: Theme.of(context).textTheme.bodySmall
                                                )
                                            )
                                        );
                                      case  FileUploaderStatus.progressFailure :
                                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                                backgroundColor:Theme.of(context).colorScheme.errorContainer,
                                                content:Text(
                                                  state.errorMessage,
                                                  style: Theme.of(context).textTheme.bodySmall
                                                )
                                            )
                                        );
                                        setState(() {
                                          _progressError = "Failed";
                                        });
                                      case FileUploaderStatus.progress:
                                        setState(() {
                                            _progress = "progress : ${state.progress} %";
                                        });
                                      default:
                                    }*/

                                  },
                                  child: BlocBuilder<FileUploaderBloc,FileUploaderState>(
                                    buildWhen: (previous, current) {
                                      final excludedStatuses = [
                                          /*FileUploaderStatus.failure,
                                          FileUploaderStatus.permissionsDenied,
                                          FileUploaderStatus.progress,
                                          FileUploaderStatus.success,
                                          FileUploaderStatus.progressFailure*/
                                      ];

                                      return !excludedStatuses.contains(current.status);                                    },
                                    builder: (context,state) {
                                      switch (state.status){
                                        case FileUploaderStatus.loading:
                                          return  Center(
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                )
                                              )
                                          );
                                        case FileUploaderStatus.cameraOrGallery:
                                          return Center(
                                              child: Flexible(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(child: Text("Upload from ?",style: Theme.of(context).textTheme.titleSmall)),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                              context.read<FileUploaderBloc>().add(FileUploaderUploadSourceRequested(UploadSourceType.camera));
                                                          },
                                                          child: Card(
                                                            shadowColor: Colors.white.withOpacity(0.3),
                                                            color: Colors.transparent,
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.camera,size: 30,color: Theme.of(context).colorScheme.tertiary),
                                                                  Text("camera",style: Theme.of(context).textTheme.titleSmall)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text("or",style: Theme.of(context).textTheme.titleSmall),
                                                        SizedBox(width: 10),
                                                        InkWell(
                                                          onTap:(){
                                                            context.read<FileUploaderBloc>().add(FileUploaderUploadSourceRequested(UploadSourceType.gallery));
                                                          },
                                                          child: Card(
                                                              shadowColor: Colors.white.withOpacity(0.3),
                                                              color: Colors.transparent,
                                                              child:Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                                child: Column(
                                                                  children: [
                                                                    Icon(Icons.library_add_sharp,size: 30,color: Theme.of(context).colorScheme.tertiary),
                                                                    Text("gallery",style: Theme.of(context).textTheme.titleSmall)
                                                                  ],
                                                                ),
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                          );
                                        case FileUploaderStatus.pictureOrVideo:
                                          return Center(
                                              child: Flexible(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Flexible(child: Text("Picture or video ?",style: Theme.of(context).textTheme.titleSmall)),
                                                    SizedBox(height: 5),
                                                    Row(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: [
                                                        InkWell(
                                                          onTap: (){
                                                            context.read<FileUploaderBloc>().add(FileUploaderUploadTypeRequested(MediaType.picture));
                                                          },
                                                          child: Card(
                                                            shadowColor: Colors.white.withOpacity(0.3),
                                                            color: Colors.transparent,
                                                            child: Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                                              child: Column(
                                                                children: [
                                                                  Icon(Icons.image,size: 30,color: Theme.of(context).colorScheme.tertiary),
                                                                  Text("image",style: Theme.of(context).textTheme.titleSmall)
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10),
                                                        Text("or",style: Theme.of(context).textTheme.titleSmall),
                                                        SizedBox(width: 10),
                                                        InkWell(
                                                          onTap:(){
                                                            context.read<FileUploaderBloc>().add(FileUploaderUploadTypeRequested(MediaType.video));
                                                          },
                                                          child: Card(
                                                              shadowColor: Colors.white.withOpacity(0.3),
                                                              color: Colors.transparent,
                                                              child:Container(
                                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                                child: Column(
                                                                  children: [
                                                                    Icon(Icons.video_camera_back,size: 30,color: Theme.of(context).colorScheme.tertiary),
                                                                    Text("video",style: Theme.of(context).textTheme.titleSmall)
                                                                  ],
                                                                ),
                                                              )
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              )
                                          );
                                        case FileUploaderStatus.initial:
                                            return InkWell(
                                                      onTap:(){
                                                        context.read<FileUploaderBloc>().add(FileUploaderUploadRequested());
                                                      },
                                                      child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            Icon(Icons.folder, color: Theme.of(context).colorScheme.tertiary, size: 45),
                                                            Text(
                                                                'Upload your files here',
                                                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                                                    fontSize: 8,
                                                                    color: Theme.of(context).textTheme.titleSmall?.color?.withOpacity((0.8))
                                                                )
                                                            )
                                                          ]
                                                      )
                                            );
                                        case FileUploaderStatus.readyToUpload:
                                          return Padding(
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
                                          );
                                        default : return Text("Unknown status");

                                      }
                                    }
                                  ),
                                ),
                              ),
                            ),
                          )
                      ),
                      if(_config.nextPageAppRoute != null)
                      ...[
                        SizedBox(height: 10,),
                        Expanded(
                          flex: 1,
                          child: BlocBuilder<FileUploaderBloc,FileUploaderState>(
                            builder: (context, state) => Align(
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if(state.status != FileUploaderStatus.initial)
                                  ElevatedButton(
                                    child: Text("Back",style: TextStyle(fontSize: 10)),
                                    onPressed: () {
                                        context.read<FileUploaderBloc>().add(FileUploaderResetRequested());
                                    },
                                  ),
                                  const SizedBox(width: 5),
                                  if(_config.nextPageAppRoute!=null)
                                  ElevatedButton(
                                    child: Text(
                                      "Next",
                                      /*style: TextStyle(
                                          fontSize: 10,
                                          color: state.status==FileUploaderStatus.success
                                              ?Theme.of(context).colorScheme.onPrimary
                                              :Theme.of(context).colorScheme.onError
                                      ),*/
                                    ),
                                    onPressed: /*state.status!=FileUploaderStatus.success ? null: */() {
                                      Navigator.of(context).pushNamed(_config.nextPageAppRoute!);
                                    },
                                    style: ButtonStyle(
                                      textStyle: WidgetStateTextStyle.resolveWith(
                                          (Set<WidgetState> states){
                                              if (states.contains(WidgetState.disabled)) {
                                                return TextStyle(color:Theme.of(context).colorScheme.primary);
                                              }
                                              return TextStyle(color:Theme.of(context).colorScheme.primary); // Enabled state
                                          }
                                      ),
                                      backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                                          (Set<WidgetState> states){
                                            if (states.contains(WidgetState.disabled)) {
                                              return Theme.of(context).colorScheme.secondary; // Disabled state
                                            }
                                            return Theme.of(context).colorScheme.tertiary; // Enabled state
                                          }
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]
                    ],
                  )
              )
          )
        ),
      ),
    );
  }
}


extension FileExtensions on File {
  /// Gets the file size and formats it as a human-readable string.
  Future<String> getFormattedSize({int decimals = 2}) async {
    int bytes = await this.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    int i = (math.log(bytes) / math.log(1024)).floor();
    double result = bytes / math.pow(1024, i);
    return "${result.toStringAsFixed(decimals)} ${suffixes[i]}";
  }

  /// Returns the file name (with extension) of this file.
  String getFilename() {
    return "${path.basename(this.path).substring(0,10)}...${path.basename(this.path).split(".").last}";
  }
}
import "dart:io";
import "package:alpha_flutter_project/home/home.dart";
import "package:alpha_flutter_project/social_media_file_uploader_form/view/file_uploader_view.dart";
import "../bloc/file_uploader.bloc.dart";
import "../models/models.dart";
import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'dart:math' as math;
import 'package:path/path.dart' as path;
import "../widgets/widgets.dart";
import "package:localization_service/localization_service.dart";
class FileUploaderPage extends StatefulWidget {
  const FileUploaderPage({super.key});

  @override
  State<FileUploaderPage> createState() => _FileUploaderPageState();
}

class _FileUploaderPageState extends State<FileUploaderPage> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileUploaderBloc,FileUploaderState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        switch(state.pageStatus){
          case FileUploaderPageStatus.initial :
            context.read<FileUploaderBloc>().add(FileUploaderStarted());
            return Center(child: Text(context.tr("initial")));
          case FileUploaderPageStatus.started : return FileUploaderView(state);
          case FileUploaderPageStatus.failure : return FailureWithReset(state);
        }
      },
    );
  }
}

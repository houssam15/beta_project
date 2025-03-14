import "dart:io";
import "package:alpha_flutter_project/home/home.dart";
import "../bloc/file_uploader.bloc.dart";
import "../models/models.dart";
import "package:dotted_border/dotted_border.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import 'dart:math' as math;
import 'package:path/path.dart' as path;
import "../widgets/widgets.dart";

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
        switch(state.status){
          case FileUploaderStatus.started :
            context.read<FileUploaderBloc>().add(FileUploaderStarted());
            return Container();
          case FileUploaderStatus.initial : return TitleAndExtensions(state);
          default : return Container();
        }
      },
    );
  }
}

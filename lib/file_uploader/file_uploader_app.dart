import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/file_uploader/bloc/file_uploader.bloc.dart";
import "package:alpha_flutter_project/file_uploader/theme/app_theme.dart";
import "package:alpha_flutter_project/file_uploader/view/file_uploader_page.dart";
import "package:alpha_flutter_project/home/home_layout.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:file_uploader_repository/file_uploader_repository.dart' show FileUploaderRepository,GlobalParams;
import "../simple_bloc_observer.dart";
import "./models/models.dart";




class FileUploaderApp extends StatefulWidget {
  static final String route = Config.fileUploaderAppRoute;
  const FileUploaderApp({super.key});

  @override
  State<FileUploaderApp> createState() => _FileUploaderAppState();
}

class _FileUploaderAppState extends State<FileUploaderApp> {
  Config get config => Config();
  @override
  void initState() {
    Bloc.observer = SimpleBlocObserver();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return HomeLayout(
        selectedRoute: FileUploaderApp.route,
        body: Theme(
            data: AppTheme().themeData,
            child: BlocProvider<FileUploaderBloc>(
              create: (_) => FileUploaderBloc(
                  FileUploaderRepository(
                    globalParams: GlobalParams(
                      fileChunkedUploadBaseUrl: config.mediaUploadBaseUrl,
                      fileChunkedUploadPath: config.mediaLargeFileUploadEndpoint
                    )
                  )
              ),
              child: FileUploaderPage(),
            )
        )
    );
  }
}

import "package:alpha_flutter_project/authentication/authentication.dart";
import "./bloc/file_uploader.bloc.dart";
import "./theme/app_theme.dart";
import "./view/file_uploader_page.dart";
import "package:alpha_flutter_project/home/home_layout.dart";
import "package:flutter/material.dart";
import 'package:file_uploader_repository/file_uploader_repository.dart' show FileUploaderRepository,GlobalParams;
import "../simple_bloc_observer.dart";
import "./models/models.dart";


class SocialMediaFileUploaderForm extends StatefulWidget {
  static final String route = Config.appRoute;
  const SocialMediaFileUploaderForm({super.key});

  @override
  State<SocialMediaFileUploaderForm> createState() => _SocialMediaFileUploaderFormState();
}

class _SocialMediaFileUploaderFormState extends State<SocialMediaFileUploaderForm> {
  Config get config => Config();
  @override
  void initState() {
    Bloc.observer = SimpleBlocObserver();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return HomeLayout(
        title: "File uploader" ,
        selectedRoute: SocialMediaFileUploaderForm.route,
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

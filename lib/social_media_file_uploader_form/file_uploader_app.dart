import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:localization_service/localization_service.dart";
import "./bloc/file_uploader.bloc.dart";
import "./theme/app_theme.dart";
import "./view/file_uploader_page_v2.dart";
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
    final localizationService = LocalizationService(Localizations.localeOf(context),feature: "social_media_file_uploader_form/lang");
    return MaterialApp(
        localeResolutionCallback: LocalizationService.localeResolutionCallback,
        supportedLocales: LocalizationService.supportedLocales,
        localizationsDelegates: localizationService.localizationsDelegate,
        home: HomeLayout(
          hideAppbar: true,
          selectedRoute: SocialMediaFileUploaderForm.route,
          body: Theme(
              data: AppTheme().themeData,
              child: BlocProvider<FileUploaderBloc>(
                create: (_) => FileUploaderBloc(
                    FileUploaderRepository(
                      globalParams: GlobalParams(
                        fileChunkedUploadBaseUrl: config.mediaUploadBaseUrl,
                        fileChunkedUploadPath: config.mediaLargeFileUploadEndpoint,
                        fileChunkedUploadAuthorizationToken: config.authorizationToken
                      )
                    )
                ),
                child: FileUploaderPage(),
              )
          )
      ),
    );
  }
}

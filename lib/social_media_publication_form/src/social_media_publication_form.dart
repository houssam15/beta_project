import "package:alpha_flutter_project/common/common.dart";
import "package:alpha_flutter_project/common/src/layouts/home_layout.dart";
import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import "../../simple_bloc_observer.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "models/models.dart";
import "theme/app_theme.dart";
import "./bloc/bloc.dart";
import "./view/social_media_publication_form_view.dart";
import "social_media_publication_form_arguments.dart";
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;
import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;

class SocialMediaPublicationForm extends StatefulWidget {
  static final String route = Config.appRoute;
  const SocialMediaPublicationForm({super.key});

  @override
  State<SocialMediaPublicationForm> createState() => _SocialMediaPublicationFormState();
}

class _SocialMediaPublicationFormState extends State<SocialMediaPublicationForm> {

  @override
  void initState() {
    Bloc.observer = SimpleBlocObserver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    SocialMediaPublicationFormArguments? args = ModalRoute.of(context)?.settings.arguments as SocialMediaPublicationFormArguments?;

    return FeatureLayout<SocialMediaPublicationFormArguments>(
        params: args ?? SocialMediaPublicationFormArguments().create(),
        selectedRoute: Config.appRoute,
        lang: LangParams("${Config.featureName}/src/lang"),
        theme: ThemeParams(AppTheme().themeData),
        providers: [
          BlocProvider<SocialMediaPublicationFormRemoteBloc>(
            create: (_) => SocialMediaPublicationFormRemoteBloc(
                uploadDocumentResponse: args!.uploadDocumentResponse!,
                fileUploaderRepository:fur.FileUploaderRepository.create<fcu.UploadDocumentResponse>(
                  /*globalParams: fur.GlobalParams(
                      baseUrl: Config.baseUrl,
                      fileChunkedUploadPath: Config.updateDocumentEndpoint,
                      authorizationToken: Config.token
                  ),*/
                  //fromJson: (json, {token}) => fcu.UploadDocumentResponse().fromJson(json,token: token),
                  fileChunkedUploader: fcu.FileChunkedUploader(
                    fcu.Config(
                      baseUrl: Config.baseUrl,
                      path: Config.updateDocumentEndpoint,
                      authorizationToken: Config.token
                    ),
                    (json, {token}) => fcu.UploadDocumentResponse().fromJson(json,token: token)
                  )
                ),
                mediaType: args.mediaType,
                constrains: args.constrains,
                currentState: args.currentState
            ),
            child: SocialMediaPublicationFormView(),
          )
        ],
        child: SocialMediaPublicationFormView()
    );

    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: LocalizationService.localeResolutionCallback,
      supportedLocales: LocalizationService.supportedLocales,
      localizationsDelegates: localizationService.localizationsDelegate,
      home: HomeLayout(
          selectedRoute: SocialMediaPublicationForm.route,
          hideAppbar: true,
          body: Theme(
              validation: AppTheme().themeData,
              child: args?.uploadDocumentResponse==null
                  ?ErrorMessageWidget(context.tr("No file selected"),refresh: false)
                  :BlocProvider<SocialMediaPublicationFormRemoteBloc>(
                create: (_) => SocialMediaPublicationFormRemoteBloc(
                    uploadDocumentResponse: args!.uploadDocumentResponse!,
                    fileUploaderRepository:fur.FileUploaderRepository.create<fcu.UploadDocumentResponse>(
                        globalParams: fur.GlobalParams(
                            baseUrl: Config.baseUrl,
                            fileChunkedUploadPath: Config.updateDocumentEndpoint,
                            authorizationToken: Config.token
                        ),
                        fromJson: (json, {token}) => fcu.UploadDocumentResponse().fromJson(json,token: token),
                    ),
                    mediaType: args.mediaType,
                    constrains: args.constrains,
                    currentState: args.currentState
                ),
                child: SocialMediaPublicationFormView(),
              )
          )
      ),
    );*/
  }

}

import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/common/common.dart";
import "package:localization_service/localization_service.dart";
import "./bloc/file_uploader.bloc.dart";
import "./theme/app_theme.dart";
import "./view/file_uploader_page_v2.dart";
import "package:alpha_flutter_project/common/src/layouts/home_layout.dart";
import "package:flutter/material.dart";
import 'package:file_uploader_repository/file_uploader_repository.dart' show FileUploaderRepository,GlobalParams;
import "../simple_bloc_observer.dart";
import "./models/models.dart";
import "social_media_file_uploader_form_arguments.dart";
import "package:file_chunked_uploader/file_chunked_uploader.dart" as fcu;


class SocialMediaFileUploaderForm extends StatefulWidget {
  static final String route = Config.appRoute;
  SocialMediaFileUploaderForm({super.key,this.arguments});
  SocialMediaFileUploaderFormArguments? arguments;
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
    SocialMediaFileUploaderFormArguments args = SocialMediaFileUploaderFormArguments().create(widget.arguments ?? ModalRoute.of(context)?.settings.arguments);

    return FeatureLayout<SocialMediaFileUploaderFormArguments>(
        params: args,
        selectedRoute: Config.appRoute,
        lang: LangParams("social_media_file_uploader_form/lang"),
        theme: ThemeParams(AppTheme().themeData),
        providers: [
          BlocProvider<FileUploaderBloc>(
            create: (_) => FileUploaderBloc(
                uploadDocumentResponse:args.uploadDocumentResponse,
                mediaType:args.mediaType,
                constrains:args.constrains,
                currentState:args.previousState,
                fileUploaderRepository:args.modifySingleDocumentForPublication?
                FileUploaderRepository.create<fcu.UploadDocumentResponseForNetwork>(
                  /*globalParams: GlobalParams(
                      baseUrl: Config.mediaUploadBaseUrl,
                      fileChunkedUploadPath: Config.mediaLargeFileUploadForNetworkEndpoint,
                      authorizationToken: Config.authorizationToken
                  ),*/
                  //fromJson: (json, {token}) => fcu.UploadDocumentResponseForNetwork().fromJson(json,token: token),
                  fileChunkedUploader: fcu.FileChunkedUploader(
                    fcu.Config(
                      baseUrl: Config.mediaUploadBaseUrl,
                      path: Config.mediaLargeFileUploadForNetworkEndpoint,
                      authorizationToken: Config.authorizationToken
                    ),
                    (json, {token}) => fcu.UploadDocumentResponseForNetwork().fromJson(json,token: token)
                  )
                )
                :FileUploaderRepository.create<fcu.UploadDocumentResponse>(
                  /*globalParams: GlobalParams(
                      baseUrl: Config.mediaUploadBaseUrl,
                      fileChunkedUploadPath: Config.mediaLargeFileUploadEndpoint,
                      authorizationToken: Config.authorizationToken
                  ),*/
                  //fromJson: (json, {token}) => fcu.UploadDocumentResponse().fromJson(json,token: token),
                  fileChunkedUploader: fcu.FileChunkedUploader(
                    fcu.Config(
                        baseUrl: Config.mediaUploadBaseUrl,
                        path: Config.mediaLargeFileUploadEndpoint,
                        authorizationToken: Config.authorizationToken
                    ),
                    (json, {token}) => fcu.UploadDocumentResponse().fromJson(json,token: token)
                  )
                ),
                modifySingleDocumentForPublication:args.modifySingleDocumentForPublication,
                publicationId:args.publicationId,
                accountId: args.accountId
            ),
          )
        ],
        child: FileUploaderPage()
    );
/*
    final localizationService = LocalizationService(Localizations.localeOf(context),feature: "social_media_file_uploader_form/lang");
    SocialMediaFileUploaderFormArguments args = SocialMediaFileUploaderFormArguments.create(widget.arguments ?? ModalRoute.of(context)?.settings.arguments);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: LocalizationService.localeResolutionCallback,
        supportedLocales: LocalizationService.supportedLocales,
        localizationsDelegates: localizationService.localizationsDelegate,
        home: HomeLayout(
          hideAppbar: true,
          hideSidebar: args.hideSidebar??false,
          selectedRoute: SocialMediaFileUploaderForm.route,
          body: Theme(
              validation: AppTheme().themeData,
              child: BlocProvider<FileUploaderBloc>(
                create: (_) => FileUploaderBloc(
                    uploadDocumentResponse:args.uploadDocumentResponse,
                    mediaType:args.mediaType,
                    constrains:args.constrains,
                    currentState:args.previousState,
                    fileUploaderRepository:args.modifySingleDocumentForPublication?
                        FileUploaderRepository.create<fcu.UploadDocumentResponseForNetwork>(
                            globalParams: GlobalParams(
                              baseUrl: Config.mediaUploadBaseUrl,
                              fileChunkedUploadPath: Config.mediaLargeFileUploadForNetworkEndpoint,
                              authorizationToken: Config.authorizationToken
                            ),
                            fromJson: (json, {token}) => fcu.UploadDocumentResponseForNetwork().fromJson(json,token: token),
                        )
                        :FileUploaderRepository.create<fcu.UploadDocumentResponse>(
                              globalParams: GlobalParams(
                                  baseUrl: Config.mediaUploadBaseUrl,
                                  fileChunkedUploadPath: Config.mediaLargeFileUploadEndpoint,
                                  authorizationToken: Config.authorizationToken
                              ),
                              fromJson: (json, {token}) => fcu.UploadDocumentResponse().fromJson(json,token: token),
                        ),
                    modifySingleDocumentForPublication:args.modifySingleDocumentForPublication,
                    publicationId:args.publicationId,
                    accountId: args.accountId
                ),
                child: FileUploaderPage(),
              )
          )
      ),
    );
*/
  }
}

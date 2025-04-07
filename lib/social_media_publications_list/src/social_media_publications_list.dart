import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/common/src/layouts/home_layout.dart";
import "package:alpha_flutter_project/social_media_list_form/src/widgets/error_message.dart";
import "package:flutter/material.dart";
import "config/config.dart";
import "social_media_publications_list_params.dart";
import "view/social_media_list_publications_view.dart";
import "package:localization_service/localization_service.dart";
import "config/config.dart";
import "theme/app_theme.dart";
import "package:alpha_flutter_project/common/common.dart";
import "bloc/bloc.dart";
class SocialMediaPublicationsList extends StatefulWidget {
  static String route = SocialMediaPublicationsListConfig.appRoute;
  SocialMediaPublicationListParams? params;

  SocialMediaPublicationsList({super.key,this.params});

  @override
  State<SocialMediaPublicationsList> createState() => _SocialMediaPublicationsListState();
}

class _SocialMediaPublicationsListState extends State<SocialMediaPublicationsList> {

  @override
  Widget build(BuildContext context) {
    widget.params =widget.params ?? SocialMediaPublicationListParams().create(ModalRoute.of(context)?.settings.arguments);
    final localizationService = LocalizationService(Localizations.localeOf(context),feature: SocialMediaPublicationsListConfig.langPath);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: LocalizationService.localeResolutionCallback,
      supportedLocales: LocalizationService.supportedLocales,
      localizationsDelegates: localizationService.localizationsDelegate,
      home: HomeLayout(
          selectedRoute: SocialMediaPublicationsList.route,
          hideAppbar: true,
          body: Theme(
              data: AppTheme().themeData,
              child: widget.params==null || widget.params?.isValid()==false
                  ? ErrorMessageWidget(context.tr("Invalid params"))
                  : MultiBlocProvider(
                  providers: [
                    //Remote bloc
                    BlocProvider<SocialMediaPublicationsListRemoteBloc>(
                        create: (_) => SocialMediaPublicationsListRemoteBloc()
                    ),
                    //Local bloc
                    /*BlocProvider<SocialMediaPublicationsListLocalBloc>(
                        create: (_) => SocialMediaPublicationsListLocalBloc()
                    )*/
                  ],
                  child: SocialMediaListPublicationsView()
              )
          ),
      ),
    );
  }
}

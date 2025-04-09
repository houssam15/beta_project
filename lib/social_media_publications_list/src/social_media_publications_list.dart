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
    return FeatureLayout<SocialMediaPublicationListParams>(
        params: SocialMediaPublicationListParams().create(widget.params ?? SocialMediaPublicationListParams().create(ModalRoute.of(context)?.settings.arguments)),
        selectedRoute: SocialMediaPublicationsListConfig.appRoute,
        lang: LangParams(SocialMediaPublicationsListConfig.langPath),
        theme: ThemeParams(AppTheme().themeData),
        providers: [
          BlocProvider<SocialMediaPublicationsListRemoteBloc>(
              create: (_) => SocialMediaPublicationsListRemoteBloc()
          ),
        ],
        child: SocialMediaListPublicationsView()
    );
  }
}

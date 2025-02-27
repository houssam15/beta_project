import "package:alpha_flutter_project/home/home_layout.dart";
import "package:flutter/material.dart";
import "../../simple_bloc_observer.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import "models/models.dart";
import "theme/app_theme.dart";
import "./bloc/bloc.dart";
import "./view/social_media_publication_form_page.dart";

class SocialMediaPublicationForm extends StatefulWidget {
  static final String route = Config.appRoute;
  const SocialMediaPublicationForm({super.key});

  @override
  State<SocialMediaPublicationForm> createState() => _SocialMediaPublicationFormState();
}

class _SocialMediaPublicationFormState extends State<SocialMediaPublicationForm> {
  Config get config => Config();

  @override
  void initState() {
    Bloc.observer = SimpleBlocObserver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeLayout(
        selectedRoute: SocialMediaPublicationForm.route,
        body: Theme(
            data: AppTheme().themeData,
            child: BlocProvider<SocialMediaPublicationFormRemoteBloc>(
              create: (_) => SocialMediaPublicationFormRemoteBloc(),
              child: SocialMediaPublicationFormPage(),
            )
        )
    );
  }

}

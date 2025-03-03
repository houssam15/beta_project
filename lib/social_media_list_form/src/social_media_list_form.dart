import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "../../home/home_layout.dart";
import "bloc/remote/social_media_list_form.remote.bloc.dart";
import "social_media_list_form_arguments.dart";
import "./models/models.dart";
import "./theme/app_theme.dart";
import "./view/social_media_list_form_page.dart";

class SocialMediaListForm extends StatefulWidget {
  static final String route = Config.appRoute;

  const SocialMediaListForm({super.key});

  @override
  State<SocialMediaListForm> createState() => _SocialMediaListFormState();
}

class _SocialMediaListFormState extends State<SocialMediaListForm> {
  @override
  Widget build(BuildContext context) {

    final args = SocialMediaListFormArguments().fromJson(ModalRoute.of(context)?.settings.arguments);

    return HomeLayout(
        selectedRoute: SocialMediaListForm.route,
        title: args.appBarTitle,
        body: Theme(
            data: AppTheme().themeData,
            child: BlocProvider<SocialMediaListFormRemoteBloc>(
              create: (_) => SocialMediaListFormRemoteBloc(),
              child: SocialMediaListFormPage(),
            )
        )
    );
  }
}

import "package:flutter/material.dart";
import "social_media_list_form_arguments.dart";
class SocialMediaFileUploaderForm extends StatefulWidget {
  const SocialMediaFileUploaderForm({super.key});

  @override
  State<SocialMediaFileUploaderForm> createState() => _SocialMediaFileUploaderFormState();
}

class _SocialMediaFileUploaderFormState extends State<SocialMediaFileUploaderForm> {
  @override
  Widget build(BuildContext context) {

    final args = SocialMediaListFormArguments().fromJson(ModalRoute.of(context)?.settings.arguments);

    return HomeLayout(
        selectedRoute: SocialMediaPublicationForm.route,
        title: args.appBarTitle,
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

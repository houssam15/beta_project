import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_publications_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";
import "../../widgets/widgets.dart";
class SocialMediaListPublicationsInitialPage extends StatelessWidget {
  const SocialMediaListPublicationsInitialPage({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;
  @override
  Widget build(BuildContext context) {
    context.read<SocialMediaPublicationsListRemoteBloc>().add(SocialMediaPublicationsListRemoteListPublicationsRequested(context: context));
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  LoadingPublications()
              ]
          ),
        ),
      ),
    );
  }
}

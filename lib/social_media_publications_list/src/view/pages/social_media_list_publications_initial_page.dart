import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:alpha_flutter_project/social_media_publications_list/src/bloc/bloc.dart";
import "package:flutter/material.dart";

class SocialMediaListPublicationsInitialPage extends StatelessWidget {
  const SocialMediaListPublicationsInitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SocialMediaPublicationsListRemoteBloc>().add(SocialMediaPublicationsListRemoteListPublicationsRequested());
    return Center(child: Text("Initial"),);
  }
}

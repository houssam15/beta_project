import "package:flutter/material.dart";

import "../../bloc/remote/social_media_publications_list_remote_bloc.dart";

class SocialMediaListPublicationsPublicationDetailsPage extends StatelessWidget {
  const SocialMediaListPublicationsPublicationDetailsPage({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Initial"));
  }
}

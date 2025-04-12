import "package:flutter/material.dart";
import "../../bloc/remote/social_media_publications_list_remote_bloc.dart";
import "../../widgets/widgets.dart";
class SocialMediaListPublicationsFailedPage extends StatelessWidget {
  const SocialMediaListPublicationsFailedPage({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom:100),
          child: FailedToGetData(remoteState: remoteState)
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class SocialMediaPublicationFormFailurePage extends StatefulWidget {
  const SocialMediaPublicationFormFailurePage(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;
  @override
  State<SocialMediaPublicationFormFailurePage> createState() => _SocialMediaPublicationFormFailurePageState();
}

class _SocialMediaPublicationFormFailurePageState extends State<SocialMediaPublicationFormFailurePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Failure"),
    );
  }
}

import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class MyTitle extends StatelessWidget {
  const MyTitle(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
      child: Center(
        child: Text(context.tr("Publication details")),
      ),
    );
  }
}

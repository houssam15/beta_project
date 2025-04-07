import "package:flutter/material.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class SelectPublishDate extends StatelessWidget {
  const SelectPublishDate(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "select publish date",
          style: TextStyle(
              fontSize: 12
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class SelectPublishTime extends StatelessWidget {
  const SelectPublishTime(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "select publish time",
          style: TextStyle(
              fontSize: 12
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

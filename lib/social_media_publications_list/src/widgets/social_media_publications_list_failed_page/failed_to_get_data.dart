import "package:flutter/material.dart";

import "../../bloc/remote/social_media_publications_list_remote_bloc.dart";

class FailedToGetData extends StatelessWidget {
  const FailedToGetData({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/social_media_publications_list/error.png"),
          SizedBox(height: 20),
          Text(remoteState.errorMessage)
        ]
    );
  }
}

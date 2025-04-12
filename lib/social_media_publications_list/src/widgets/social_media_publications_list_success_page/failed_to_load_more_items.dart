import "package:flutter/material.dart";

import "../../bloc/remote/social_media_publications_list_remote_bloc.dart";

class FailedToLoadMoreItems extends StatelessWidget {
  const FailedToLoadMoreItems({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
          padding:const EdgeInsets.symmetric(horizontal: 5),
          child: Text(remoteState.errorMessage,style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
      ),
    );
  }
}

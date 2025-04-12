import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";

import "../../bloc/remote/social_media_publications_list_remote_bloc.dart";

class PublicationsListEmpty extends StatelessWidget {
  const PublicationsListEmpty({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/social_media_publications_list/empty_box.png"),
          SizedBox(height: 20),
          Text(context.tr("No element found !"))
        ]
    );
  }
}

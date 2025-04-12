import "package:flutter/material.dart";
import "package:localization_service/localization_service.dart";
import "../../bloc/remote/social_media_publications_list_remote_bloc.dart";
import "../../widgets/widgets.dart";

class SocialMediaListPublicationsSuccessPage extends StatelessWidget {
  const SocialMediaListPublicationsSuccessPage({super.key,required this.remoteState});
  final SocialMediaPublicationsListRemoteState remoteState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom:100),
        child: Container(
          width: double.infinity,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.tr("Search")),
                      Text("${remoteState.totalInvalidItems}")
                    ],
                  ),
                ),
                Expanded(
                    child: remoteState.publications.isEmpty
                        ? PublicationsListEmpty(remoteState:remoteState)
                        : PublicationsList(remoteState:remoteState)
                )
              ]
          ),
        ),
      ),
    );
  }
}

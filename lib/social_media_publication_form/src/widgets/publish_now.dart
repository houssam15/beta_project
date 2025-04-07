import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class PublishNow extends StatefulWidget {
  PublishNow(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;

  @override
  State<PublishNow> createState() => _PublishNowState();
}

class _PublishNowState extends State<PublishNow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Publish now",
              style: TextStyle(
                  fontSize: 12
              ),
            ),
            Transform.scale(
              scale: 0.6,
              child: CupertinoSwitch(
                value: widget.remoteState.publishNow,
                onChanged: (value) {
                  context.read<SocialMediaPublicationFormRemoteBloc>().add(SocialMediaPublicationFormRemotePublishNowChanged(value));
                },
                activeTrackColor: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        )
    );
  }
}

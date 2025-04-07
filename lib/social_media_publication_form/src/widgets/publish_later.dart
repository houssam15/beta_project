import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../bloc/remote/social_media_publication_form.remote.bloc.dart";

class PublishLater extends StatefulWidget {
  const PublishLater(this.remoteState,{super.key});
  final SocialMediaPublicationFormRemoteState remoteState;

  @override
  State<PublishLater> createState() => _PublishLaterState();
}

class _PublishLaterState extends State<PublishLater> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Decide publish time later",
              style: TextStyle(
                  fontSize: 12
              ),
            ),
            Transform.scale(
              scale: 0.6,
              child: CupertinoSwitch(
                value: widget.remoteState.decidePublishTimeLater,
                onChanged: (value) {
                  context.read<SocialMediaPublicationFormRemoteBloc>().add(SocialMediaPublicationFormRemotePublishLaterChanged(value));
                },
                activeTrackColor: Theme.of(context).colorScheme.primary,
              ),
            )
          ],
        )
    );
  }
}

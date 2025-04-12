import "package:flutter/material.dart";

import "../../models/social_media_publication/social_media_publication.dart";

class PublicationsListItem extends StatelessWidget {
  PublicationsListItem({super.key,required this.publication,required this.index});
  SocialMediaPublication publication;
  int index;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text('${index + 1}', style:Theme.of(context).textTheme.bodySmall),
      title: Text("${publication.title.label} ${publication.id}"),
      isThreeLine: true,
      subtitle: Text(publication.title.fullValue),
      dense: true,
    );
  }
}

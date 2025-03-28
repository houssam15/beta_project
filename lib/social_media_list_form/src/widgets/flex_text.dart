import "package:flutter/material.dart";

import "../models/models.dart";

class FlexText extends StatelessWidget {
  FlexText(this.socialMediaItem,{super.key});
  final SocialMediaItem socialMediaItem;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        socialMediaItem.title,
        overflow: socialMediaItem.showText?null:TextOverflow.ellipsis,// Optional: Use this to add '...' if it overflows
        style: TextStyle(
            color:socialMediaItem.hasError()?Theme.of(context).colorScheme.secondary:null,
            decoration: socialMediaItem.hasError()?TextDecoration.lineThrough:null,
            decorationColor: socialMediaItem.hasError()?Theme.of(context).colorScheme.error:null,
            decorationThickness: socialMediaItem.hasError()?2.5:null
        ),
      ),
    );
  }
}

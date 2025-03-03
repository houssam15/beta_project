import "package:alpha_flutter_project/authentication/authentication.dart";
import "package:flutter/material.dart";
import "../bloc/remote/social_media_list_form.remote.bloc.dart";
import "../models/models.dart";
class SocialMediaCheckboxWidget extends StatefulWidget {
  const SocialMediaCheckboxWidget({super.key,required this.socialMediaItem,required this.index});

  final SocialMediaItem socialMediaItem;
  final int index;

  @override
  State<SocialMediaCheckboxWidget> createState() => _SocialMediaCheckboxWidgetState();
}

class _SocialMediaCheckboxWidgetState extends State<SocialMediaCheckboxWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
            value: widget.socialMediaItem.isSelected,
            onChanged: (value) => setState(() {
              widget.socialMediaItem.changeIsSelected(value);
              context.read<SocialMediaListFormRemoteBloc>().add(SocialMediaListFormRemoteSocialMediaItemToggled());
            })
        ),
        Icon( widget.socialMediaItem.icon),
        const SizedBox(width: 5),
        Expanded(
            child: Wrap(
              children:[
                InkWell(
                  onTap:()=>setState(() {
                    widget.socialMediaItem.toggleShowText();
                  }),
                  child: Text(
                    widget.socialMediaItem.title,
                    overflow: widget.socialMediaItem.showText?null:TextOverflow.ellipsis,// Optional: Use this to add '...' if it overflows
                  ),
                )
              ],
            )
        )
      ],
    );
  }
}

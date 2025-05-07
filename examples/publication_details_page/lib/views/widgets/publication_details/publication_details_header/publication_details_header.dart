import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";

part "publication_details_header_date_holder.dart";
part "publication_details_header_social_media_list.dart";
part "publication_details_header_state.dart";

class PublicationDetailsHeader extends StatelessWidget {
  const PublicationDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey,
      margin: EdgeInsets.all(8),
      height: 70,
      child: Column(
        children: [
          //social media list and publication state holder
          Expanded(
            child: Row(
              children: [
                PublicationDetailsHeaderSocialMediaList(),
                PublicationDetailsHeaderState()
              ],
            ),
          ),
          //created at & published at
          Expanded(
            child: Row(
              children: [
                PublicationDetailsHeaderDateHolder(date: "published at : 11/11/2011 11:11 pm",textAlign: TextAlign.start),
                PublicationDetailsHeaderDateHolder(date:"Created at : 11/11/2011 11:11 pm",textAlign: TextAlign.end)
              ],
            ),
          )
        ],
      ),
    );
  }
}

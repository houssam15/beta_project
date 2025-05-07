import "package:flutter/material.dart";
part "publication_details_footer_actions_edit.dart";

class PublicationDetailsFooter extends StatelessWidget {
  const PublicationDetailsFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey,
      height: 40,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PublicationDetailsFooterActionsEdit()
        ],
      ),
    );
  }
}


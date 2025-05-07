import "package:flutter/material.dart";
import "package:image_viewer/image_viewer.dart" as image_viewer;
import "package:video_viewer/video_viewer.dart";

part "publication_details_body_title.dart";
part "publication_details_body_description.dart";
part "publication_details_body_file.dart";
part "publication_details_body_file_picture_player.dart";
part "publication_details_body_file_video_player.dart";

class PublicationDetailsBody extends StatelessWidget {
  const PublicationDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        //color: Colors.grey,
        margin: EdgeInsets.all(8),
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Column(//flex vertical
            children: [
              PublicationDetailsBodyTitle(),
              PublicationDetailsBodyDescription(),
              PublicationDetailsBodyFile()
            ],
          ),
        )
      ),
    );
  }
}

part of "publication_details_body.dart";

class PublicationDetailsBodyFileVideoPlayer extends StatelessWidget {
  const PublicationDetailsBodyFileVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: VideoProvider().fromAssets("assets/videos/video_1.mp4"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return VideoViewer(snapshot.data);
          }
        }
    );
  }
}

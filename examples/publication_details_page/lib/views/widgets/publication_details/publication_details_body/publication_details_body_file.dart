part of "publication_details_body.dart";

class PublicationDetailsBodyFile extends StatelessWidget {
  const PublicationDetailsBodyFile({super.key});

  bool get _isPublicationPicture => false;

  bool get _isPublicationVideo => true;

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (_isPublicationPicture) {
      child = PublicationDetailsBodyFilePicturePlayer();
    } else if (_isPublicationVideo) {
      child = PublicationDetailsBodyFileVideoPlayer();
    } else {
      child = SizedBox.shrink();
    }

    return Container(
      color: Colors.white,
      width:double.infinity,
      height: 300,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      child: Center(child: child)
    );
  }
}

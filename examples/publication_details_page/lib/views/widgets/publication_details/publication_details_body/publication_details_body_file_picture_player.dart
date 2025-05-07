part of "publication_details_body.dart";

class PublicationDetailsBodyFilePicturePlayer extends StatelessWidget {
  const PublicationDetailsBodyFilePicturePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: image_viewer.ImageProvider().fromAssets("assets/images/image_1.jpeg"),
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return CircularProgressIndicator();
        }else if(snapshot.hasError){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset("assets/images/image_broken.png")
              ),
              Text("Can't load image !")
            ],
          );
        }else{
          return image_viewer.ImageViewer(imageProvider: snapshot.data!);
        }
      },
    );
  }
}

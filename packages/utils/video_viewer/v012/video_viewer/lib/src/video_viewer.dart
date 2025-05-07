import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:video_viewer/src/config/config.dart';
import 'package:video_viewer/src/models/models.dart';

class VideoViewer extends StatefulWidget {

  VideoViewer([this.videoProvider]);

  VideoProvider? videoProvider;

  static bool _initialized = false;

  static ensureInitialized(){
    MediaKit.ensureInitialized();
    _initialized = true;
  }

  static void checkInitialization() {
    assert(_initialized, "You must call VideoViewer.ensureInitialized() in main()");
  }

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late final player = Player();
  late final controller = VideoController(player);
  final VideoViewerConfig config = VideoViewerConfig();
  bool hasError = false;
  String errorMessage = "";
  @override
  void initState() {

    super.initState();

    VideoViewer.checkInitialization();

    if(widget.videoProvider==null){
      setState(() {
        hasError = true;
        errorMessage = "Contact support please !";
      });
    }else if(widget.videoProvider!.isValid()){
      player.open(widget.videoProvider!.getMedia());
    }

  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    if(hasError){
      return Center(
        child: Text(errorMessage)
      );
    }

    if(!widget.videoProvider!.isValid()){
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              height: 30,
              width: 30,
              child: Image.asset("assets/images/video_broken.png")
          ),
          Text("Can't load video !")
        ],
      );
    }

    return Video(controller: controller);
  }
}

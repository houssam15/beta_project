import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoViewer extends StatefulWidget {
  VideoViewer({super.key,required this.media});
  Media media;

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late final player = Player();
  late final controller = VideoController(player);
  @override
  void initState() {
    super.initState();
    MediaKit.ensureInitialized();
    player.open(widget.media);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Video(controller: controller);
  }
}

import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class VideoViewer extends StatefulWidget {
  const VideoViewer({super.key});

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
    player.open(Media('https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4'));
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child:Video(controller: controller),
    );
  }
}

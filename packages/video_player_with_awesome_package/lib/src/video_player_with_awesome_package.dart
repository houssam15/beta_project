import "package:flutter/material.dart";
import 'package:awesome_video_player/awesome_video_player.dart';

class VideoPlayerWithAwesomePackage extends StatefulWidget {
  const VideoPlayerWithAwesomePackage({super.key});

  @override
  State<VideoPlayerWithAwesomePackage> createState() => _VideoPlayerWithAwesomePackageState();
}

class _VideoPlayerWithAwesomePackageState extends State<VideoPlayerWithAwesomePackage> {
  @override
  Widget build(BuildContext context) {
    return BetterPlayer.network(
      "https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4",
    );
  }
}

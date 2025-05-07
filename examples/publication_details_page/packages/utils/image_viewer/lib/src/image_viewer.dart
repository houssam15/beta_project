import "package:flutter/material.dart";
import "package:photo_view/photo_view.dart";
import "models/models.dart" as models;

class ImageViewer extends StatefulWidget {
  final models.ImageProvider imageProvider;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  ImageViewer({
    super.key,
    required this.imageProvider,
    Color? backgroundColor,
    BorderRadiusGeometry? borderRadius
  }):backgroundColor = Colors.black.withOpacity(0.4),
    borderRadius = BorderRadius.all(Radius.circular(10));

  @override
  State<ImageViewer> createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  @override
  Widget build(BuildContext context) {
    return widget.imageProvider.validateResult()
    ?PhotoView(
        imageProvider: widget.imageProvider.getImageProvider(),
        backgroundDecoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius
        ),
      minScale: PhotoViewComputedScale.contained,
      //maxScale: PhotoViewComputedScale.covered * 2.0,
      initialScale: PhotoViewComputedScale.contained,
      enablePanAlways: false,
    )
    :Center(
      child: Text("Can't load image"),
    );
  }
}

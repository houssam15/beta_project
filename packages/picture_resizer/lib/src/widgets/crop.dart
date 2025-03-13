import "dart:io";

import "package:crop/crop.dart";
import "package:flutter/material.dart";

class CropWidget extends StatefulWidget {
  double rotation;
  final CropController  controller;
  BoxShape shape;
  File imageFile;
  CropWidget({
    super.key,
    required this.rotation,
    required this.controller,
    required this.shape,
    required this.imageFile
  });

  @override
  State<CropWidget> createState() => _CropWidgetState();
}

class _CropWidgetState extends State<CropWidget> {

  _onChange(decomposition) {
    if (widget.rotation != decomposition.rotation) {
      setState(() {
        widget.rotation = ((decomposition.rotation + 180) % 360) - 180;
      });
    }
    print("Scale : ${decomposition.scale}, Rotation: ${decomposition.rotation}, translation: ${decomposition.translation}");
  }

  @override
  Widget build(BuildContext context) {
    return Crop(
      onChanged: _onChange,
      controller: widget.controller,
      shape: widget.shape,
      foreground: IgnorePointer(),
      helper: widget.shape == BoxShape.rectangle
          ?Container(
              decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
            ),
          )
          : null,
      child: Image.file(
        widget.imageFile,
        fit: BoxFit.cover
      ),
    );
  }
}

import "dart:io";

import "package:crop/crop.dart";
import "package:flutter/material.dart";

class CropWidget extends StatefulWidget {
  final double rotation;
  final CropController  controller;
  BoxShape shape;
  File imageFile;
  double width;
  double height;

  CropWidget({
    super.key,
    required this.rotation,
    required this.controller,
    required this.shape,
    required this.imageFile,
    required this.width,
    required this.height
  });

  @override
  State<CropWidget> createState() => _CropWidgetState();
}

class _CropWidgetState extends State<CropWidget> {



  _onChange(decomposition) {
    if (widget.rotation != decomposition.rotation) {
      setState(() {
        //widget.rotation = ((decomposition.rotation + 180) % 360) - 180;
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
      zoneHeight: widget.height,
      zoneWidth: widget.width,
      foreground: IgnorePointer(),
      helper: widget.shape == BoxShape.rectangle
          ?Container(
              decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              //color : Colors.red
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

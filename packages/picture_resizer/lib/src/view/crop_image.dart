import 'dart:io';
import 'package:crop/crop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import "../widgets/widgets.dart";
import "../models/models.dart";
import "view.dart";
import 'dart:ui' as ui;

class CropImage extends StatefulWidget {

  File file;
  BuildContext context;
  ValidConstraints validConstraints;
  String? extension;
  CropImage({
    super.key,
    required this.file,
    required this.context,
    required this.validConstraints,
    required this.extension
  });

  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  //CropController get controller => CropController(aspectRatio: (widget.maxWidth/2) / (widget.maxHeight/2));
  late CropController  controller ;
  late double width;
  late double height;
  double _rotation = 0;
  BoxShape shape = BoxShape.rectangle;


  @override
  void initState() {
    width = widget.validConstraints.minWidth;
    height = widget.validConstraints.minHeight;
    controller = CropController(aspectRatio: width / height);
    super.initState();
  }

  void _cropImage() async {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final ui.Image? cropped = await controller.crop(pixelRatio: pixelRatio);

    if (cropped == null || !mounted) return;

    final  isSave = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CropImageResult(image: cropped,extension: widget.extension,width:width,height:height),
        fullscreenDialog: true,
      )
    );
    //if(kDebugMode) print(isSave);
    if(isSave){
      Navigator.of(context).pop(cropped);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(cropImage: _cropImage),
      body:Column(
        children: [
          Column(
            children: [
              Text("Width: ${width.toInt()} px"),
              Slider(
                value: width,
                min: widget.validConstraints.minWidth,
                max: widget.validConstraints.maxWidth,
                divisions: (widget.validConstraints.maxWidth - widget.validConstraints.minWidth).toInt(),
                label: "${width.toInt()}",
                onChanged: (value) {
                  setState(() {
                    width = value;
                    controller.aspectRatio =  width / height;
                  });
                },
              ),
              Text("Height: ${height.toInt()} px"),
              Slider(
                value: height,
                min: widget.validConstraints.minHeight,
                max: widget.validConstraints.maxHeight,
                divisions: (widget.validConstraints.maxHeight - widget.validConstraints.minHeight).toInt(),
                label: "${height.toInt()}",
                onChanged: (value) {
                  setState(() {
                    height = value;
                    controller.aspectRatio =  width / height;
                  });
                  print(height);
                },
              ),

            ],
          ),
          Expanded(
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.all(8),
                child: CropWidget(
                    rotation: _rotation,
                    controller: controller,
                    shape: shape,
                    imageFile: widget.file
                ),
              )
          ),
          Row(
            children: [
              UndoButtonWidget(
                  popMenuIcon:const Icon(Icons.undo),
                  popMenuTooltip:'Undo',
                  controller:controller,
                  rotation:_rotation
              ),
              RotationSlider(
                  controller:controller,
                  rotation:_rotation
              ),
              /*
              CropShapeWidget(
                  popMenuIcon:const Icon(Icons.crop_free),
                  popMenuTooltip:'Crop Shape',
                  shape: shape,
                  cropShapesOptions: CropShapeOption.getTestingData()
              ),
              AspectRatioWidget(
                  controller:controller,
                  aspectRatioOptions:AspectRatioOption.getTestingData()
              )*/
            ],
          )
        ],
      )
    );
  }
}

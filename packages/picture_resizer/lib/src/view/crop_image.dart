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
  List<ValidConstraints> validConstraints;
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
  late List<AspectRatioOption> aspectRatioOptions;
  String? _selectedAspectRatio;

  @override
  void initState() {
    if(widget.validConstraints.isNotEmpty){
      width = widget.validConstraints.first.minWidth;
      height = widget.validConstraints.first.minHeight;
      _selectedAspectRatio = widget.validConstraints.first.ratio;
      controller = CropController(aspectRatio: widget.validConstraints.first.toValue()!);
    }else{
      controller = CropController();
    }

    aspectRatioOptions = widget.validConstraints.map((elm)=>AspectRatioOption(elm.toValue(),elm.ratio)).toList();

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

  ValidConstraints? _getSelectedConstraint() {
    var filteredList = widget.validConstraints
        .where((elm) => elm.ratio == _selectedAspectRatio);

    return filteredList.isNotEmpty ? filteredList.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(cropImage: _cropImage),
      body:Column(
        children: [
          if(_selectedAspectRatio != null)
          Column(
            children: [
              Text("Width: ${width.toInt()} px"),
              Slider(
                value: width,
                min: _getSelectedConstraint()!.minWidth,
                max: _getSelectedConstraint()!.maxWidth,
                divisions: (_getSelectedConstraint()!.maxWidth - _getSelectedConstraint()!.minWidth).toInt(),
                label: "${width.toInt()}",
                onChanged: (value) {
                  setState(() {
                    width = value;
                    if(_selectedAspectRatio=="1:1"){
                      height = value;
                    }
                    controller.aspectRatio =  width / height;
                  });
                },
              ),
              Text("Height: ${height.toInt()} px"),
              Slider(
                value: height,
                min: _getSelectedConstraint()!.minHeight,
                max: _getSelectedConstraint()!.maxHeight,
                divisions: (_getSelectedConstraint()!.maxHeight - _getSelectedConstraint()!.minHeight).toInt(),
                label: "${height.toInt()}",
                onChanged: (value) {
                  setState(() {
                    height = value;
                    if(_selectedAspectRatio=="1:1"){
                      width = value;
                    }
                    controller.aspectRatio =  width / height;
                  });
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
              ),*/
              AspectRatioWidget(
                  controller:controller,
                  aspectRatioOptions:aspectRatioOptions,
                  onSelected: (x) {
                    controller.aspectRatio = x;
                    _selectedAspectRatio = aspectRatioOptions.firstWhere((elm)=>elm.value == x,orElse: () => aspectRatioOptions.first).title;
                    final cons = _getSelectedConstraint();
                    if(cons != null){
                      width = cons.minWidth;
                      height = cons.minHeight;
                    }
                    setState(() {});
                  },
              )
            ],
          )
        ],
      )
    );
  }
}

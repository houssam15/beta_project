import 'dart:io';
import 'package:crop/crop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import "../widgets/widgets.dart";
import "../models/models.dart";
import "view.dart";
import 'dart:ui' as ui;
import "package:native_exif/native_exif.dart";


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
  late CropController controller;
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
      controller = CropController(aspectRatio: widget.validConstraints.first.toValue()!,);
    }else{
      controller = CropController();
    }

    aspectRatioOptions = widget.validConstraints.map((elm)=>AspectRatioOption(elm.toValue(),elm.ratio)).toList();

    super.initState();
  }

  void _cropImage() async {
    try{
      await controller.crop(pixelRatio: MediaQuery.of(context).devicePixelRatio);
      if (controller.croppedImage == null || !mounted) return;

      // 1. Get raw image bytes
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch.toString()}.${widget.extension}';
      //ByteData? bytes = await controller.croppedImage?.toByteData();
      if(controller.croppedImage == null) throw Exception("Can't convert uiImage to ByteData");

      // 2. Save initial cropped file (without EXIF)
      File croppedFile = File(filePath);
      await croppedFile.writeAsBytes(controller.croppedImage!);

      // 3 decode cropped image
      //final imageBytes = await croppedFile.readAsBytes();

      // 4 update exif
      final croppedExif = await Exif.fromPath(croppedFile.path);
      dynamic originMetaDataAttributes = await croppedExif.getAttribute("TAG_ORIENTATION");
      print(originMetaDataAttributes);
      /*originMetaDataAttributes['PixelXDimension'] = controller.croppedImage?.width.toString();
      originMetaDataAttributes['PixelYDimension'] = controller.croppedImage?.height.toString();
      await originalExif.close();*/

      // 5 update cropped image with new exif data
      //final tempPath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch.toString()}_edited.${widget.extension}';
      //await File(tempPath).writeAsBytes(imageBytes);
      //final exif = await Exif.fromPath(tempPath);
      //await exif.writeAttribute("UserComment", "1000");
      //await exif.close();
      //await exif.writeAttributes(originMetaDataAttributes);

      // 6 update cropped file with valid data
      //await croppedFile.delete();
      //await File(tempPath).rename(croppedFile.path);



      final  isSave = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CropImageResult(image: controller.croppedImage,extension: widget.extension,width:width,height:height),
            fullscreenDialog: true,
          )
      );

      if(isSave){
        Navigator.of(context).pop(ResizedPicture(file: croppedFile/* , exifData: originMetaDataAttributes*/));
      }
    }catch(err){
      print(err);
      Navigator.of(context).pop(null);
    }

  }

  ValidConstraints? _getSelectedConstraint() {
    var filteredList = widget.validConstraints
        .where((elm) => elm.ratio == _selectedAspectRatio);

    return filteredList.isNotEmpty ? filteredList.first : null;
  }
  

  double getXMultiplayer(){
    double? mpt = double.tryParse((_selectedAspectRatio?.split(":").first).toString());
    if(mpt==null|| mpt <=0) return 1;
    return mpt;
  }

  double getYMultiplayer(){
    double? mpt = double.tryParse((_selectedAspectRatio?.split(":").last).toString());
    if(mpt==null || mpt <=0 ) return 1;
    return mpt;
  }

  double _getSizePercentage() {
    final constraint = _getSelectedConstraint();
    double per = 0;
    if (constraint == null || constraint.minWidth >= width) {
      per = 0.0;
    }else {
      final widthRange = constraint.maxWidth;
      if (widthRange <= 0) {
        per = 1.0;
      }else{
        per = (width / widthRange).clamp(0.0, 1.0);
      }
    }
    //print("per : ${per * 100} %");
    return per;
  }


  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(cropImage: _cropImage),
      body:Column(
        children: [
          if(_selectedAspectRatio != null)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Size : ${width.toInt()}/${height.toInt()} px"),
                    Text(
                        "Aspect ratio : ${_selectedAspectRatio.toString()}",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                    )
                  ],
                ),
              ),
              Slider(
                value: _sliderValue,
                min: 0,
                max: 100,
                divisions: 100,
                label: "${_sliderValue.toInt()} %",
                /*onChanged: (value) {
                  setState(() {
                    double acw = (_getSelectedConstraint()!.maxWidth) * value/100;
                    if(acw <= _getSelectedConstraint()!.minWidth){
                      acw = _getSelectedConstraint()!.minWidth;
                    }
                    width = acw;
                    height = acw * getYMultiplayer()/getXMultiplayer();
                    _sliderValue = value;
                    //controller.aspectRatio =  width / height;
                    //controller.scale = (width/(_getSelectedConstraint()!.maxWidth - _getSelectedConstraint()!.minWidth).toInt());
                  });
                },*/
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;

                    final constraint = _getSelectedConstraint();
                    if (constraint != null) {
                      // Calculate width based on slider percentage
                      double minWidth = constraint.minWidth;
                      double maxWidth = constraint.maxWidth;

                      // When slider is at 0, use minWidth
                      if (value == 0) {
                        width = minWidth;
                      } else {
                        // Linear interpolation between min and max width
                        width = minWidth + (maxWidth - minWidth) * (value / 100);
                      }

                      // Maintain aspect ratio for height
                      height = width * getYMultiplayer() / getXMultiplayer();

                      // Update controller if needed
                      controller.aspectRatio = width / height;
                    }
                  });
                },
              ),
              /*Text("Width: ${width.toInt()} px"),
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
              ),*/
              /*Text("Height: ${height.toInt()} px"),
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
              ),*/

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
                    imageFile: widget.file,
                    width:width,
                    height: height,
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

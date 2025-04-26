import 'dart:io';
import 'package:crop/crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;  // Image manipulation library
import 'package:picture_resizer/src/utils/image_helper.dart';
import 'package:picture_resizer_v2/picture_resizer_v2.dart' as prv2;
import 'models/models.dart';
import "view/view.dart";
import 'dart:ui' as ui;

extension ValidConstraintsMapping on ValidConstraints{
  prv2.ValidConstraints toValidConstraintsV2(){
    return prv2.ValidConstraints(
      minHeight: this.minHeight,
      maxHeight: this.maxHeight,
      minWidth: this.minWidth,
      maxWidth: this.maxWidth,
      ratio: this.ratio
    );
  }
}

class PictureResizer {
  List<ValidConstraints>? _validConstraints;
  File? _file;
  BuildContext? _context;
  String? _extension;
  dynamic _originalBytes;
  dynamic _originalMetaData;
  ResizedPicture? _resizedPicture;

  PictureResizer setValidConstraints(List<ValidConstraints>? validConstraints) {
    _validConstraints = validConstraints;
    return this;
  }

  PictureResizer setFile(File? file) {
    _file = file;
    return this;
  }

  File? getFile(){
    return _file;
  }

  PictureResizer setContext(BuildContext? context){
    _context = context;
    return this;
  }

  PictureResizer setExtension(String? extension){
    _extension = extension;
    return this;
  }

  PictureResizer setOriginalBytes(bytes){
    _originalBytes = bytes;
    return this;
  }

  getOriginalBytes(){
    return _originalBytes;
  }

  getOriginalMetaData(){
    return _originalMetaData;
  }

  PictureResizer setOriginalMetaData(metaData){
    _originalMetaData = metaData;
    return this;
  }

  PictureResizer setResizedPicture(ResizedPicture? resizedPicture){
    _resizedPicture = resizedPicture;
    return this;
  }

  ResizedPicture? getResizedPicture(){
    return _resizedPicture;
  }


   resizePicture() async {
    try{
      if(_context==null || _file==null || _validConstraints==null || _extension==null) throw Exception("Invalid params !");
      String? cropFilePath = await prv2.PictureResizerV2(
          file: _file!,
          context: _context!,
          validConstraints: _validConstraints!.map<prv2.ValidConstraints>(((elm)=>elm.toValidConstraintsV2())).toList(),
          extension: _extension
      ).cropPicture();
      if(cropFilePath==null) return null;
      this.setResizedPicture(
        ResizedPicture(file: await cropFilePath.toFile(extension: _extension))
      );
    }catch(err){
      if(kDebugMode) print(err);
    }
  }

  /*resizePicture() async {
    try{
      if(_context==null || _file==null || _validConstraints==null || _extension==null) throw Exception("Invalid params !");
      this.setResizedPicture(
          await Navigator.push(
            _context!,
            MaterialPageRoute(
                builder: (context) => CropImage(
                  file: _file!,
                  context: _context!,
                  validConstraints: _validConstraints!,
                  extension: _extension,
                )
            ),
          )
      );
    }catch(err){
      if(kDebugMode) print(err);
    }
  }*/

}

import 'dart:io';
import 'package:crop/crop.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;  // Image manipulation library
import 'package:picture_resizer/src/utils/image_helper.dart';
import 'models/models.dart';
import "view/view.dart";
import 'dart:ui' as ui;

class PictureResizer {
  List<ValidConstraints>? _validConstraints;
  File? _file;
  BuildContext? _context;
  String? _extension;

  PictureResizer setValidConstraints(List<ValidConstraints>? validConstraints) {
    _validConstraints = validConstraints;
    return this;
  }

  PictureResizer setFile(File? file) {
    _file = file;
    return this;
  }

  PictureResizer setContext(BuildContext? context){
    _context = context;
    return this;
  }

  PictureResizer setExtension(String? extension){
    _extension = extension;
    return this;
  }

  Future<File?> resizePicture() async {
    try{
      if(_context==null || _file==null || _validConstraints==null || _extension==null) throw Exception("Invalid params !");
      //if(_validConstraints?.isValid()==false) throw Exception("Valid constrains are not valid !");
      ui.Image? crop = await Navigator.push(
        _context!,
        MaterialPageRoute(
          builder: (context) => CropImage(
              file: _file!,
              context: _context!,
              validConstraints: _validConstraints!,
              extension: _extension,
          )
        ),
      );
      File? file = await crop?.toFile(extension: _extension);
      if(file is File) return file;
    }catch(err){
      if(kDebugMode) print(err);
      return null;
    }
  }

}

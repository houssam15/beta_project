import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import "package:native_exif/native_exif.dart";

extension UiImageConveter on ui.Image{

  Future<File?> toFile({String? extension = "png"}) async{
    try{
      if(extension==null) throw Exception("Invalid exception");
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${_generateFileName()}.$extension';
      File file = File(filePath);
      ByteData? bytes = await toByteData();
      if(bytes == null) throw Exception("Can't convert uiImage to ByteData");
      await file.writeAsBytes(bytes.buffer.asUint8List());
      return file;
    }catch(err){
      if(kDebugMode) print(err);
      return null;
    }
  }
  // Dummy file name generator
  String _generateFileName() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<File?> convertUiImageToFileWithOriginalMetadata(
      {String? extension = "png",required File originalFile}
  )async {
    try{
      if(extension==null) throw Exception("Invalid exception");
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/${_generateFileName()}.$extension';
      File croppedFile = File(filePath);
      ByteData? bytes = await toByteData();
      if(bytes == null) throw Exception("Can't convert uiImage to ByteData");
      await croppedFile.writeAsBytes(bytes.buffer.asUint8List());
      // Read original EXIF
      final originalExif = await Exif.fromPath(originalFile.path);
      final attributes = await originalExif.getAttributes();
      if(attributes==null) return null;
      // Write to cropped file
      final croppedExif = await Exif.fromPath(croppedFile.path);
      await croppedExif.writeAttributes(attributes);
      return croppedFile;
    }catch(err){
      return null;
    }

  }

}

extension FilePathMapping on String {
  Future<File?> toFile({String? extension = "png"}) async{
    try{
      if(extension==null) throw Exception("Invalid exception");
      File file = File(this);
      final originalExif = await Exif.fromPath(file.path);
      final attributes = await originalExif.getAttributes();
      if(attributes==null) return null;
      return file;
    }catch(err){
      return null;
    }
  }
}



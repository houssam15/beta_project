import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';


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

}



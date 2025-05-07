import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import "package:flutter/src/painting/image_provider.dart" as image_provider;
import 'dart:ui' as ui;

enum Extensions{
  png,jpg
}

extension StringMapper on String{
  Extensions toExtension(){
    switch(this){
      case "png":return Extensions.png;
      case "jpg":return Extensions.jpg;
      default: throw Exception("Unknown extension !");
    }
  }
}

extension ExtensionMapper on Extensions{
  ui.ImageByteFormat toImageByteFormat(){
    switch(this){
      case Extensions.png:return ui.ImageByteFormat.png;
      case Extensions.jpg:
        print("Warning: JPEG is not supported, using PNG instead.");
        return ui.ImageByteFormat.png;
    }
  }
}

class ImageProvider{
  image_provider.ImageProvider? _imageProvider;
  Extensions? _extensions;

  image_provider.ImageProvider<Object>? getImageProvider(){
    return _imageProvider;
  }

  ImageProvider setImageProvider(image_provider.ImageProvider? imageProvider){
    _imageProvider = imageProvider;
    return this;
  }

  ImageProvider setExtension(String? extension) {
    _extensions = extension?.toExtension();
    return this;
  }

  bool validateResult(){
    return _imageProvider != null;
  }

  bool validateParams(dynamic image){
    return _extensions != null && image != null;
  }



  Future<ImageProvider> fromUiImage(ui.Image? uiImage) async{
    try{
       if(!validateParams(uiImage)) throw Exception("Invalid params");
        //1 - convert to binary Uint8List
       ByteData? byteData = await uiImage?.toByteData(format: _extensions!.toImageByteFormat());
       if (byteData == null) {
         throw Exception("Failed to convert ui.Image to ByteData");
       }
       //2 - convert binary to memory image
       Uint8List uint8List = byteData.buffer.asUint8List();
       _imageProvider = image_provider.MemoryImage(uint8List);
    }catch(err){
      if(kDebugMode) print(err);
    }
    return this;
  }

  Future<ImageProvider> fromUrl(String? imageUrl) async{
    try{
      if(imageUrl==null) return this;
      _imageProvider =  image_provider.NetworkImage(imageUrl);
    }catch(err){
      if(kDebugMode) print(err);
    }
    return this;
  }

  Future<ImageProvider> fromFile(File? file) async {
    try{
      if(file==null) return this;
      Uint8List bytes = await file.readAsBytes();
      _imageProvider = image_provider.MemoryImage(bytes);
    }catch(err){
      if(kDebugMode) print(err);
    }
    return this;
  }

  Future<ImageProvider> fromMemory(Uint8List? bytes) async {
    try{
      if(bytes == null) throw Exception("Invalid params");
      _imageProvider =  image_provider.MemoryImage(bytes);
    }catch(err){
      print(err);
    }
    return this;
  }

  Future<ImageProvider> fromAssets(String path,{String? packageName}) async{
    try{
      String p = "";
      if(packageName !=null){
        p+="$packageName/";
      }
      p+=path;
      ByteData bytes = await rootBundle.load(p);
      await fromMemory(bytes.buffer.asUint8List());
    }catch(err){
      print(err);
      rethrow;
    }
    return this;
  }

}
import "dart:io";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:media_kit/media_kit.dart";

class VideoProvider {
  Media? _media;

  //Media('https://user-images.githubusercontent.com/28951144/229373695-22f88f13-d18f-4288-9bf1-c3e078d83722.mp4')
  Future<VideoProvider> fromUrl(String? url) async {
    try{
      if(url==null) throw Exception("Invalid url $url");
      return this..setMedia(Media(url));
    }catch(err){
      if(kDebugMode) print(err);
      return this;
    }
  }

  Future<VideoProvider> fromAssets(String? path,{String? packageName}) async {
    try{
      if(path == null) throw Exception("Invalid path $path");
      String p = "";
      if(packageName != null){
        p+="$packageName/";
      }
      p+=path;
      ByteData data = await rootBundle.load(p);
      Uint8List bytes = data.buffer.asUint8List();
      return this..setMedia(await Media.memory(bytes));
    }catch(err){
      if(kDebugMode) print(err);
      return this;
    }
  }
  
  Future<VideoProvider> fromFile(File? file) async {
    try{
      if(file == null) throw Exception("Invalid file");
      Uint8List bytes = await file.readAsBytes();
      return this..setMedia(await Media.memory(bytes));
    }catch(err){
      if(kDebugMode) print(err);
      return this;
    }
  }

  void setMedia(Media m){
    _media = m;
  }

  Media getMedia(){
    if(_media==null){
      throw Exception("Invalid media file");
    }else{
      return _media!;
    }
  }

  bool isValid(){
    return _media !=null;
  }

}
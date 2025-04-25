import 'dart:io';

class ResizedPicture {
  File? file;
  Map<String,dynamic>? exifData;

  ResizedPicture({
    this.file,
    this.exifData
  });

  File? getFile(){
    return file;
  }

  Map<String,dynamic>? getExifData(){
    return exifData;
  }

  bool isValid(){
    return file != null;
  }
}
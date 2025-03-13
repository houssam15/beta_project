import 'dart:io';

enum Extensions{
  png,jpg
}

extension StringConverter on String{
  Extensions toFileExtension(){
    switch(this){
      case "png": return Extensions.png;
      case "jpg": return Extensions.jpg;
      default: throw Exception("Unknown file name extension");
    }
  }
}

extension ExtensionConverter on Extensions{
  String toExtensionString(){
    switch(this){
      case Extensions.png: return "png";
      case Extensions.jpg: return "jpg";
    }
  }
}

class UploadedPicture{
  final File file;
  final Extensions extension;

  const UploadedPicture({
    required this.file,
    required this.extension
  });
}
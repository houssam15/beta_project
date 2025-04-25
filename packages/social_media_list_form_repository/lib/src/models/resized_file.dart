import 'dart:io';

class ResizedFile {
    final File file;
    final Map<String,dynamic>? exifData;
    const ResizedFile({required this.file,this.exifData});
}
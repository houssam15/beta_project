import 'dart:io';

import './models/models.dart';
import "package:image_picker/image_picker.dart";
import 'package:path/path.dart' as path;

/*
Messages:
- file type not supported
- user cancel operation
- file picked successfully
*/

class LocalFilePicker{
  final ImagePicker _picker = ImagePicker();
  LocalFile _localFile = LocalFile();


  Future<LocalFile> pickFile(LocalFileSource localSource,LocalFileType localFileType,{List<String>? supportedExtensions,double? minSize,double? maxSize}) async {
      try{
        await _pickMedia(localSource.toImageSource(),localFileType,supportedExtensions:supportedExtensions,minSize:minSize,maxSize:maxSize);
      }catch(err){
        _localFile.set(
            status: LocalFileStatus.failed,
            error: LocalFileError(message: err.toString())
        );
      }
      return _localFile;
  }

   _pickMedia(ImageSource source,LocalFileType type,{List<String>? supportedExtensions,double? minSize,double? maxSize}) async {
         XFile? pic;
        if (type==LocalFileType.picture) {
          pic = await _picker.pickImage(source: source);
        }else if(type==LocalFileType.video){
          pic = await _picker.pickVideo(source: source);
        }else{
          return _localFile.set(
              status: LocalFileStatus.failed,
              error: LocalFileError(message: "file type not supported")
          );
        }
         // If no file is picked
         if (pic == null) {
           return _localFile.set(
             status: LocalFileStatus.canceled,
             message: "user canceled operation",
           );
         }

         String extension = path.extension(pic.path).toLowerCase().replaceFirst(".","");

         // Check if the extension is allowed
         if (supportedExtensions != null && supportedExtensions.isNotEmpty) {
           if (!supportedExtensions.map((e) => e.toLowerCase()).contains(extension)) {
             return _localFile.set(
               status: LocalFileStatus.failed,
               message: "unsupported file format",
             );
           }
         }

         File file = File(pic.path);
         int fileSize = await file.length();

         /*if (minSize != null && fileSize < minSize) {
           return _localFile.set(
             status: LocalFileStatus.failed,
             message: "file too small"
           );
         }*/

         if (maxSize != null && fileSize > maxSize) {
           return _localFile.set(
             status: LocalFileStatus.failed,
             message: "file too large"
           );
         }

        _localFile.set(
            file: file,
            status: LocalFileStatus.picked,
            message:"file picked successfully"
        );
   }


}
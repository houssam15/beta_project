import 'dart:io';
import './models/models.dart';
import "package:image_picker/image_picker.dart";

/*
Messages:
- file type not supported
- user cancel operation
- file picked successfully
*/

class LocalFilePicker{
  final ImagePicker _picker = ImagePicker();
  LocalFile _localFile = LocalFile();

  Future<LocalFile> pickFile(LocalFileSource localSource,LocalFileType localFileType) async {
      try{
        await _pickMedia(localSource.toImageSource(),localFileType);
      }catch(err){
        _localFile.set(
            status: LocalFileStatus.failed,
            error: LocalFileError(message: err.toString())
        );
      }
      return _localFile;
  }

   _pickMedia(ImageSource source,LocalFileType type) async {
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
        _localFile.set(
            file:pic==null ? null: File(pic.path),
            status: pic==null?LocalFileStatus.canceled:LocalFileStatus.picked,
            message: pic==null?"user cancel operation":"file picked successfully"
        );
   }


}
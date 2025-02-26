import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

enum LocalFileSource{
  fromCamera,fromGallery
}
enum LocalFileType{
  picture,video
}

enum LocalFileStatus{
  picked,canceled,failed
}

extension ImagePickerUploadSourceTypeMapping on LocalFileSource{
  ImageSource toImageSource(){
    switch(this){
      case LocalFileSource.fromCamera: return ImageSource.camera;
      case LocalFileSource.fromGallery: return ImageSource.gallery;
    }
  }
}

class LocalFileError extends Equatable{
  String message;

  LocalFileError({
    this.message = "unknown error happen when try to pick file"
  });
  @override
  List<Object?> get props => [message];

}
class LocalFile extends Equatable{

  LocalFile({
    this.status = LocalFileStatus.canceled,
    this.fileSource=LocalFileSource.fromGallery,
    this.fileType=LocalFileType.picture,
    LocalFileError? error,
    this.message = "no message",
    this.file
  }):error = error ?? LocalFileError();

  LocalFileStatus status;
  LocalFileSource fileSource;
  LocalFileType fileType;
  LocalFileError error;
  File? file;
  String message;

  LocalFile set({
    LocalFileStatus? status,
    LocalFileSource? fileSource,
    LocalFileType? fileType,
    LocalFileError? error,
    File? file,
    String? message
  }){
    this.status = status ?? this.status;
    this.fileSource = fileSource ?? this.fileSource;
    this.fileType = fileType ?? this.fileType;
    this.error = error ?? this.error;
    this.file = file ?? this.file;
    this.message = message ?? this.message;
    return this;
  }

  @override
  List<Object?> get props => [fileType,fileSource,file,message];
}
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:local_file_picker/local_file_picker.dart' as local_file_picker;



enum UploadSourceType{
  camera,gallery
}

enum MediaType{
  picture,video
}

extension FileSourceTypeMapping on UploadSourceType{
  local_file_picker.LocalFileSource toLocalFileSource(){
    switch(this){
      case UploadSourceType.camera: return local_file_picker.LocalFileSource.fromCamera;
      case UploadSourceType.gallery: return local_file_picker.LocalFileSource.fromGallery;
    }
  }
}

extension UploadSourceTypeMapping on local_file_picker.LocalFileSource{
  UploadSourceType toUploadSourceType(){
    switch(this){
      case local_file_picker.LocalFileSource.fromCamera: return UploadSourceType.camera;
      case local_file_picker.LocalFileSource.fromGallery: return UploadSourceType.gallery;
    }
  }
}

extension LocalFileTypeMapping on MediaType{
  local_file_picker.LocalFileType toLocalFileType(){
    switch(this){
      case MediaType.picture: return local_file_picker.LocalFileType.picture;
      case MediaType.video: return local_file_picker.LocalFileType.video;
    }
  }
}

extension MediaTypeMapping on local_file_picker.LocalFileType{
  MediaType toMediaType(){
    switch(this){
      case local_file_picker.LocalFileType.picture: return MediaType.picture;
      case local_file_picker.LocalFileType.video: return MediaType.video;
    }
  }
}



class LocalFile extends Equatable{

  UploadSourceType source;
  MediaType type;
  File? file;
  String? message;
  bool isError;
  bool isCanceled;
  bool isSuccess;
  bool isAccessDenied;
  bool isOpenSettingsRequired;
  LocalFile({
    required this.source,
    required this.type,
    this.message,
    required this.file,
    this.isCanceled=false,
    this.isError = false,
    this.isSuccess = false,
    this.isAccessDenied = false,
    this.isOpenSettingsRequired = false
  });

  @override
  List<Object?> get props => [source,type,message,file];

}
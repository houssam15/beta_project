
import 'package:file_uploader_repository/file_uploader_repository.dart' as file_uploader_repository;

enum  UploadSourceType{
  camera,gallery,none
}

enum MediaType{
  picture,video,none
}

extension RepositoryUploadSourceTypeMapping on UploadSourceType{
  file_uploader_repository.UploadSourceType toRepositoryUploadFileSource(){
    switch(this){
      case UploadSourceType.camera: return file_uploader_repository.UploadSourceType.camera;
      case UploadSourceType.gallery: return file_uploader_repository.UploadSourceType.gallery;
      case UploadSourceType.none : throw new Exception("Unsupported source type");
    }
  }
}

extension RepositoryMediaTypeMapping on MediaType{
  file_uploader_repository.MediaType toRepositoryMediaType(){
    switch(this){
      case MediaType.picture: return file_uploader_repository.MediaType.picture;
      case MediaType.video: return file_uploader_repository.MediaType.video;
      case MediaType.none : throw new Exception("Unsupported media type");
    }
  }
}

class LocalFile{

}
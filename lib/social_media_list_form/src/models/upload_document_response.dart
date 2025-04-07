part of 'models.dart';

class UploadDocumentResponse {
  fur.UploadDocumentResponse? _repository;

  // Private constructor to prevent direct instantiation
  UploadDocumentResponse._(this._repository);

  // Factory method with default repository
  static UploadDocumentResponse create(fur.UploadDocumentResponse? repository) {
    return UploadDocumentResponse._(repository);
  }

  fur.UploadDocumentResponse? getRepository(){
    return _repository;
  }

  List<fur.UploadDocumentResponseWarning> getNetworks(){
    return this.getRepository()?.getNetworksForListForm() ?? [];
  }

  String? getUploadUrl(MediaType mediaType){
    if(mediaType == MediaType.picture){
      return this.getRepository()?.getPictureUrl();
    }else{
      return this.getRepository()?.getVideoUrl();
    }
  }

  String? getPublicationId(){
    return this.getRepository()?.getPublicationId().toString();
  }

}
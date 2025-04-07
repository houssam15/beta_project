import "package:file_uploader_repository/file_uploader_repository.dart" as fur;

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

  String? getPublicationId(){
    return getRepository()?.getPublicationId().toString();
  }

}
import "package:file_uploader_repository/file_uploader_repository.dart" as fur;

class UploadDocumentResponseForNetwork {
  fur.UploadDocumentResponseForNetwork? _repository;

  // Private constructor to prevent direct instantiation
  UploadDocumentResponseForNetwork._(this._repository);

  // Factory method with default repository
  static UploadDocumentResponseForNetwork create(fur.UploadDocumentResponseForNetwork? repository) {
    return UploadDocumentResponseForNetwork._(repository);
  }

  fur.UploadDocumentResponseForNetwork? getRepository(){
    return _repository;
  }

  bool hasErrors(){
    return _repository != null && _repository!.isValid();
  }

  String? getUploadUrl(){
    return _repository?.getUploadUrl();
  }

}
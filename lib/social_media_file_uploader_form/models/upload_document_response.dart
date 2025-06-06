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

  bool isWarningsExist(){
    return _repository?.isWarningsExist() ?? false;
  }

  bool isFileUploadedSuccessfully(){
    return _repository?.isFileUploadedSuccessfully()==true;
  }

  List<fur.UploadDocumentResponseWarning> getWarnings(){
    return _repository?.getWarnings() ?? [];
  }


  bool isFileNeedChange(){
    return true;
  }

  bool hasPicture(){
    return _repository?.getPictureUrl()!=null;
  }

  String? getPictureUrl(){
    return _repository?.getPictureUrl();
  }



}